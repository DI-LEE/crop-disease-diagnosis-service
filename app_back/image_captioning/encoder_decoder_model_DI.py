import string
import numpy as np
import pandas as pd
from numpy import array
from PIL import Image
import pickle

import tensorflow as tf

from keras.preprocessing.sequence import pad_sequences
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.utils import plot_model
from tensorflow.keras.models import Model
from tensorflow.keras.layers import Input
from tensorflow.keras.layers import Dense, BatchNormalization
from tensorflow.keras.layers import Embedding
from tensorflow.keras.layers import Dropout
from tensorflow.keras.layers import add
from tensorflow.keras.preprocessing.image import load_img, img_to_array

'''Hyperparameter'''
num_layer = 4
d_model = 512
dff = 2048
num_heads = 8
row_size = 8
col_size = 8
top_k = 10000
target_vocab_size = top_k + 1
#오버피팅 방지
dropout_rate = 0.2

'''Positional encoding'''
def get_angles(pos, i, d_model):
    angle_rates = 1 / np.power(10000, (2 * (i//2)) / np.float32(d_model))
    return pos * angle_rates


def positional_encoding_1d(position, d_model):
    angle_rads = get_angles(np.arange(position)[:, np.newaxis],
                            np.arange(d_model)[np.newaxis, :],
                            d_model)
    #짝수 인덱스에는 사인함수를 적용
    angle_rads[:, 0::2] = np.sin(angle_rads[:, 0::2])
    #홀수 인덱스에는 코사인 함수를 적용
    angle_rads[:, 1::2] = np.cos(angle_rads[:, 1::2])

    pos_encoding = angle_rads[np.newaxis, ...]

    return tf.cast(pos_encoding, dtype=tf.float32)


def positional_encoding_2d(row, col, d_model):
    assert d_model % 2 == 0

    # 첫번째 d_model/2는 행 임베딩을 인코딩하고 두번째 d_model/2는 열 임베딩을 인코딩한다.
    row_pos = np.repeat(np.arange(row), col)[:, np.newaxis]
    col_pos = np.repeat(np.expand_dims(np.arange(col), 0),
                        row, axis=0).reshape(-1, 1)

    angle_rads_row = get_angles(row_pos, np.arange(
        d_model//2)[np.newaxis, :], d_model//2)
    angle_rads_col = get_angles(col_pos, np.arange(
        d_model//2)[np.newaxis, :], d_model//2)

    # apply sin and cos to odd and even indices resp.
    angle_rads_row[:, 0::2] = np.sin(angle_rads_row[:, 0::2])
    angle_rads_row[:, 1::2] = np.cos(angle_rads_row[:, 1::2])
    angle_rads_col[:, 0::2] = np.sin(angle_rads_col[:, 0::2])
    angle_rads_col[:, 1::2] = np.cos(angle_rads_col[:, 1::2])
    pos_encoding = np.concatenate([angle_rads_row, angle_rads_col], axis=1)[
        np.newaxis, ...]
    return tf.cast(pos_encoding, dtype=tf.float32)

'''Multi-Head Attention'''
#패드 토큰 마스킹하기 - 패딩한 토큰을 모델이 입력으로 취급하지 않도록 한다.
#위에서 0으로 패딩된 패드 토큰은 1을 출력하고 나머지 토큰은 0을 출력하도록 함수를 생성함.
def create_padding_mask(seq):
    seq = tf.cast(tf.math.equal(seq, 0), tf.float32)
    return seq[:, tf.newaxis, tf.newaxis, :]  # (batch_size, 1, 1, seq_len)

#look ahead mask를 생성. look ahead mask는 모델의 학습을 위해 전체 시퀀스에서 현재 예측해야 하는 시퀀스부터 미래에 예측해야 하는 시퀀스까지 모두 마스킹하는 것.
#예를 들어 세 번째 토큰을 예측하기 위해 첫번째, 두번째 토큰만 사용하고 세번째 토큰부터는 마스킹하는 것.
def create_look_ahead_mask(size):
    mask = 1 - tf.linalg.band_part(tf.ones((size, size)), -1, 0)
    return mask  # (seq_len, seq_len)

#query, key, value로 attention weight를 계산하는데, query와 key를 내적하여 나온 스칼라 값(attention score)에 key의 차원 수(dk)의 제곱근을 나눠주어 스칼라값을 스케일링 해준다.
#스케일링 하는 이유: key의 차원이 커질수록 query와 key에 대한 내적 계산시 내적된 값이 커지는 문제를 보완하기 위해 수행.
def scaled_dot_product_attention(q, k, v, mask):
    # (..., seq_len_q, seq_len_k)
    matmul_qk = tf.matmul(q, k, transpose_b=True)
    dk = tf.cast(tf.shape(k)[-1], tf.float32)
    scaled_attention_logits = matmul_qk / tf.math.sqrt(dk)

    #마스킹되는 위치에 절댓값이 매우 작은 음수 값을 넣는다(-0.000000001)
    #나중에 소프트맥스 함수를 거치면 이 마스킹된 위치의 값은 거의 0으로 수렴한다.
    if mask is not None:
        scaled_attention_logits += (mask * -1e9)

    attention_weights = tf.nn.softmax(scaled_attention_logits, axis=-1)
    output = tf.matmul(attention_weights, v)  # (..., seq_len_q, depth_v)

    return output, attention_weights

#Multi-Head Attention : 어텐션을 여러번 병렬로 처리한다.
class MultiHeadAttention(tf.keras.layers.Layer):
    def __init__(self, d_model, num_heads):
        super(MultiHeadAttention, self).__init__()
        self.num_heads = num_heads
        self.d_model = d_model
        assert d_model % self.num_heads == 0
        self.depth = d_model // self.num_heads
        self.wq = tf.keras.layers.Dense(d_model)
        self.wk = tf.keras.layers.Dense(d_model)
        self.wv = tf.keras.layers.Dense(d_model)
        self.dense = tf.keras.layers.Dense(d_model)

    def split_heads(self, x, batch_size):
        x = tf.reshape(x, (batch_size, -1, self.num_heads, self.depth))
        return tf.transpose(x, perm=[0, 2, 1, 3])

    def call(self, v, k, q, mask=None):
        batch_size = tf.shape(q)[0]
        q = self.wq(q)  # (batch_size, seq_len, d_model)
        k = self.wk(k)  # (batch_size, seq_len, d_model)
        v = self.wv(v)  # (batch_size, seq_len, d_model)

        q = self.split_heads(q, batch_size)  # (batch_size, num_heads, seq_len_q, depth)
        k = self.split_heads(k, batch_size)  # (batch_size, num_heads, seq_len_k, depth)
        v = self.split_heads(v, batch_size)  # (batch_size, num_heads, seq_len_v, depth)

        # scaled_attention.shape == (batch_size, num_heads, seq_len_q, depth)
        # attention_weights.shape == (batch_size, num_heads, seq_len_q, seq_len_k)
        scaled_attention, attention_weights = scaled_dot_product_attention(q, k, v, mask)

        scaled_attention = tf.transpose(scaled_attention, perm=[0, 2, 1, 3])  # (batch_size, seq_len_q,      num_heads, depth)

        concat_attention = tf.reshape(scaled_attention, (batch_size, -1, self.d_model))  # (batch_size, seq_len_q, d_model)

        output = self.dense(concat_attention)  # (batch_size, seq_len_q, d_model)
        return output, attention_weights

'''Point-Wise Feed Forward Neural Network'''

def point_wise_feed_forward_network(d_model, dff):
    return tf.keras.Sequential([
                tf.keras.layers.Dense(dff, activation='relu'),  # (batch_size, seq_len, dff)
                tf.keras.layers.Dense(d_model) #(batch_size, seq_len, d_model)
                ])

'''Encoder'''
#인코더 층(layer)을 정의하기
#<구성 요소>
# 패딩 마스크가 포함된 Multi-Head Attention
# Point-Wise Feed Forward Neural Network

class EncoderLayer(tf.keras.layers.Layer):
    def __init__(self, d_model, num_heads, dff, rate=0.1):
        super(EncoderLayer, self).__init__()
        self.mha = MultiHeadAttention(d_model, num_heads)
        self.ffn = point_wise_feed_forward_network(d_model, dff)

        #층 정규화(layer normalization)
        #모델 학습을 돕기 위해 텐서의 마지막 차원에 대한 평균과 분산을 구하고 평균, 분산값을 이용한 수식으로 값을 정규화하는 과정
        self.layernorm1 = tf.keras.layers.LayerNormalization(epsilon=1e-6)
        self.layernorm2 = tf.keras.layers.LayerNormalization(epsilon=1e-6)

        #드롭아웃(Drop Out)
        #과대적합(Overfitting)을 방지하기 위해 rate의 확률로 뉴런을 제거하는 기법
        self.dropout1 = tf.keras.layers.Dropout(rate)
        self.dropout2 = tf.keras.layers.Dropout(rate)


    def call(self, x, training, mask=None):
        attn_output, _ = self.mha(x, x, x, mask)  # (batch_size, input_seq_len, d_model)
        attn_output = self.dropout1(attn_output, training=training)
        #잔차 연결(x + attn_output) -> 그래디언트 소멸 문제를 피하는데 도움을 준다.
        out1 = self.layernorm1(x + attn_output)  # (batch_size, input_seq_len, d_model)

        ffn_output = self.ffn(out1)  # (batch_size, input_seq_len, d_model)
        ffn_output = self.dropout2(ffn_output, training=training)
        #잔차 연결(out1 + ffn_output) -> 그래디언트 소멸 문제를 피하는데 도움을 준다.
        out2 = self.layernorm2(out1 + ffn_output)  # (batch_size, input_seq_len, d_model)
        return out2

#인코더 구조를 정의하기
#<구성 요소>
# 입력 임베딩 벡터
# 위치 인코딩
# N개의 인코더 층

class Encoder(tf.keras.layers.Layer):
    def __init__(self, num_layers, d_model, num_heads, dff, row_size,col_size, rate=0.1):
        super(Encoder, self).__init__()
        self.d_model = d_model
        self.num_layers = num_layers

        self.embedding = tf.keras.layers.Dense(self.d_model,activation='relu')
        self.pos_encoding = positional_encoding_2d(row_size,col_size,self.d_model)

        self.enc_layers = [EncoderLayer(d_model, num_heads, dff, rate) for _ in range(num_layers)]

        self.dropout = tf.keras.layers.Dropout(rate)

    def call(self, x, training, mask=None):
        seq_len = tf.shape(x)[1]
        x = self.embedding(x)  # (batch_size, input_seq_len(H*W), d_model)
        x += self.pos_encoding[:, :seq_len, :]
        x = self.dropout(x, training=training)

        for i in range(self.num_layers):
            x = self.enc_layers[i](x, training, mask)

        return x  # (batch_size, input_seq_len, d_model)

'''Decoder'''
#디코더 층(layer)을 정의하기
#<구성 요소>
# look-ahead 마스크와 패딩 마스크가 포함된 Masked Multi-Head Attention
# 패딩 마스크가 포함된 Multi-Head Attention. Key, Value는 인코더의 결과물을 입력값으로 받고, Query는 Masked Multi-Head Attention 층의 결과물을 입력값으로 받는다.
# Point-Wise Feed Forward Neural Network

class DecoderLayer(tf.keras.layers.Layer):
    def __init__(self, d_model, num_heads, dff, rate=0.1):
        super(DecoderLayer, self).__init__()
        self.mha1 = MultiHeadAttention(d_model, num_heads)
        self.mha2 = MultiHeadAttention(d_model, num_heads)

        self.ffn = point_wise_feed_forward_network(d_model, dff)

        self.layernorm1 = tf.keras.layers.LayerNormalization(epsilon=1e-6)
        self.layernorm2 = tf.keras.layers.LayerNormalization(epsilon=1e-6)
        self.layernorm3 = tf.keras.layers.LayerNormalization(epsilon=1e-6)

        self.dropout1 = tf.keras.layers.Dropout(rate)
        self.dropout2 = tf.keras.layers.Dropout(rate)
        self.dropout3 = tf.keras.layers.Dropout(rate)

    def call(self, x, enc_output, training,look_ahead_mask=None, padding_mask=None): # enc_output.shape == (batch_size, input_seq_len, d_model)
        # self-attention 진행 중에 현재의 query가 미래의 token을 고려하지 않도록 하기 위해 look-ahead mask를 사용함
        attn1, attn_weights_block1 = self.mha1(x, x, x, look_ahead_mask)  # (batch_size, target_seq_len, d_model)
        attn1 = self.dropout1(attn1, training=training)
        out1 = self.layernorm1(attn1 + x)

        # 인코더 출력값의 패딩된 값과 디코더 입력값의 패딩된 값을 피하기 위해 padding mask를 사용한다
        attn2, attn_weights_block2 = self.mha2(enc_output, enc_output, out1, padding_mask) 
        attn2 = self.dropout2(attn2, training=training)
        out2 = self.layernorm2(attn2 + out1)  # (batch_size, target_seq_len, d_model)

        ffn_output = self.ffn(out2)  # (batch_size, target_seq_len, d_model)
        ffn_output = self.dropout3(ffn_output, training=training)
        out3 = self.layernorm3(ffn_output + out2)  # (batch_size, target_seq_len, d_model)

        return out3, attn_weights_block1, attn_weights_block2

#디코더 구조를 정의하기
#<구성 요소>
# 출력 임베딩 벡터
# 위치 인코딩
# N개의 디코더 층

class Decoder(tf.keras.layers.Layer):
    def __init__(self, num_layers,d_model,num_heads,dff, target_vocab_size, maximum_position_encoding, rate=0.1):
        super(Decoder, self).__init__()
        self.d_model = d_model
        self.num_layers = num_layers

        self.embedding = tf.keras.layers.Embedding(target_vocab_size, d_model)
        self.pos_encoding = positional_encoding_1d(maximum_position_encoding, d_model)

        self.dec_layers = [DecoderLayer(d_model, num_heads, dff, rate) for _ in range(num_layers)]
        self.dropout = tf.keras.layers.Dropout(rate)

    def call(self, x, enc_output, training,look_ahead_mask=None, padding_mask=None):
        seq_len = tf.shape(x)[1]
        attention_weights = {}

        x = self.embedding(x)  # (batch_size, target_seq_len, d_model)
        x *= tf.math.sqrt(tf.cast(self.d_model, tf.float32))
        x += self.pos_encoding[:, :seq_len, :]
        x = self.dropout(x, training=training)

        for i in range(self.num_layers):
            x, block1, block2 = self.dec_layers[i](x, enc_output, training,
                                            look_ahead_mask, padding_mask)
            attention_weights['decoder_layer{}_block1'.format(i+1)] = block1
            attention_weights['decoder_layer{}_block2'.format(i+1)] = block2
        # x.shape == (batch_size, target_seq_len, d_model)
        return x, attention_weights

'''Transformer'''
class Transformer(tf.keras.Model):
    def __init__(self, num_layers, d_model, num_heads, dff,row_size,col_size, target_vocab_size,max_pos_encoding, rate=0.1):
        super(Transformer, self).__init__()
        self.encoder = Encoder(num_layers, d_model, num_heads, dff,row_size,col_size, rate)
        self.decoder = Decoder(num_layers, d_model, num_heads, dff, target_vocab_size,max_pos_encoding, rate)
        self.final_layer = tf.keras.layers.Dense(target_vocab_size)

    def call(self, inp, tar, training,look_ahead_mask=None,dec_padding_mask=None,enc_padding_mask=None   ):
        enc_output = self.encoder(inp, training, enc_padding_mask)  # (batch_size, inp_seq_len, d_model      )
        dec_output, attention_weights = self.decoder(
        tar, enc_output, training, look_ahead_mask, dec_padding_mask)
        final_output = self.final_layer(dec_output)  # (batch_size, tar_seq_len, target_vocab_size)
        return final_output, attention_weights

'''Define Transformer'''
def define_transformer_weights():
    transformer = Transformer(num_layer,
                            d_model,
                            num_heads,
                            dff,
                            row_size,
                            col_size,
                            target_vocab_size, 
                            max_pos_encoding=target_vocab_size,
                            rate=dropout_rate)

    '''load weights'''
    transformer.load_weights("C:/Users/DI Lee/Desktop/weight/InceptionV3_transformer_weights_ffinal/")

    return transformer