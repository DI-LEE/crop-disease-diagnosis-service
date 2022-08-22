import string
import numpy as np
import pandas as pd
from numpy import array
from PIL import Image
import pickle

import tensorflow as tf
from tensorflow.keras.preprocessing.image import load_img, img_to_array
from tensorflow.keras.preprocessing.text import Tokenizer

# from encoder_decoder_model_DI import *

#이미지 읽어오는 함수
def load_image(image_path):
    img = tf.io.read_file(image_path)
    img = tf.image.decode_jpeg(img, channels=3)
    img = tf.image.resize(img, (299, 299))
    img = tf.keras.applications.inception_v3.preprocess_input(img)
    return img, image_path

def create_masks_decoder(tar):
    look_ahead_mask = create_look_ahead_mask(tf.shape(tar)[1])
    dec_target_padding_mask = create_padding_mask(tar)
    combined_mask = tf.maximum(dec_target_padding_mask, look_ahead_mask)
    return combined_mask

#토큰화를 위해 라벨 불러와서 <start>, <end> 붙이는 함수
def load_label_start_end(caption_label_path): #caption_label_path : 라벨 경로
    attached_captions = []
    dir_labelling = pd.read_csv(caption_label_path, encoding='cp949')

    for caption in dir_labelling['captions']:
        caption = '<start> ' + caption + ' <end>'
        attached_captions.append(caption)
    
    return attached_captions

'''Captioning'''
def generate_captions(image):  # 실제 예측 함수
    """함수 개요
    1. 이미지 특징 추출 
    2. 토큰화
    3. transformer 정의 및 weight 불러오기
    4. 예측
    """
    #이미지 특징 추출 모델 정의
    image_model = tf.keras.applications.InceptionV3(include_top=False, weights='imagenet')  # InceptionV3
    new_input = image_model.input
    #이미지 분류를 하지 않으므로 마지막 layer인 softmax 층을 제거함. 즉, 이미지에서 특징만 추출
    hidden_layer = image_model.layers[-1].output
    image_features_extract_model = tf.keras.Model(new_input, hidden_layer)  # 이미지 특징 추출 모델

    temp_input = tf.expand_dims(load_image(image)[0], 0)
    img_tensor_val = image_features_extract_model(temp_input)
    img_tensor_val = tf.reshape(img_tensor_val, (img_tensor_val.shape[0], -1, img_tensor_val.shape[3]))

    #토큰화
    captions = load_label_start_end(caption_label_path)
    tokenizer = tf.keras.preprocessing.text.Tokenizer(num_words=top_k,
                                                    oov_token = '<unk>',
                                                    filters = '!"#$%&()*+.,-/:;=?@[\]^_`{|}~')
    tokenizer.fit_on_texts(captions)

    start_token = tokenizer.word_index['<start>']
    end_token = tokenizer.word_index['<end>']
    
    #모델 정의 및 웨이트 불어오는 함수 호출
    transformer = define_transformer_weights()
    
    #디코더의 입력은 처음에 start_token인 <start>
    decoder_input = [start_token]
    output = tf.expand_dims(decoder_input, 0)  # tokens
    result = []  # word list
    
    for i in range(100):
        dec_mask = create_masks_decoder(output)

        # predictions.shape == (batch_size, seq_len, vocab_size)
        predictions, attention_weights = transformer(
            img_tensor_val, output, False, dec_mask)

        # select the last word from the seq_len dimension
        predictions = predictions[:, -1:, :]  # (batch_size, 1, vocab_size)

        predicted_id = tf.cast(tf.argmax(predictions, axis=-1), tf.int32)

        # return the result if the predicted_id is equal to the end token
        if predicted_id == end_token:
            return result, tf.squeeze(output, axis=0), attention_weights

        # concatentate the predicted_id to the output which is given to the decoder as its input.
        result.append(tokenizer.index_word[int(predicted_id)])
        output = tf.concat([output, predicted_id], axis=-1)

    return result#, tf.squeeze(output, axis=0), attention_weights
