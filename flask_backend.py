import sys
from flask import Flask, request, jsonify, send_file
import json
import base64
import object_detection.detect as od
import image_captioning.generate_caption_DI as gc

sys.path.insert(0, '/home/ubuntu/projects/crop-disease-diagnosis-service')

app = Flask(__name__)
static_dir = 'object_detection/data/images/'
data_path = '/home/ubuntu/projects/crop-disease-diagnosis-service/app_back/data'


@app.route('/api', methods=['GET', 'POST'])
def model():
    r = request.method
    # front에 캡션과 이미지 json 형식으로 전달
    if r == 'GET':
        with open(data_path + "/data.json") as f:
            data = json.load(f)
        return data
    # front에서 이미지 받아와 예측 모델 구동
    elif r == 'POST':
        # base64 형태로 인코딩 되어 있는 이미지 디코딩 후 static_dir에 저장
        with open(static_dir + 'sample.jpg', "wb") as fh:
            fh.write(base64.decodebytes(request.data))
        # object detecion 모델 구동
        od_opt = od.parse_opt()
        od.main(od_opt)
        # object detection 모델 결과 base64 형태로 인코딩
        with open('object_detection/runs/detect/exp/sample.jpg', 'rb') as img:
            detections = base64.b64encode(img.read())
        # image captioning 모델 구동, list 형태로 나온 결과 string으로 변환
        captions = " ".join(gc.generate_captions(static_dir + 'sample.jpg')[0])
        # 모델 결과 dict 형태로 저장
        model_result = {"captions": captions, "detections": detections.decode()}
        # front에 전달하기 위해 dict 형태에서 json object 형태로 변환
        with open(data_path + "/data.json", "w") as fjson:
            json_result = json.dumps(model_result)
            fjson.write(json_result)
        return jsonify({
            "captions": "Detected !"})
    else:
        return jsonify({
            "captions": "Refresh again !"
        })


@app.route('/result')
def sendimage():
    # 결과 이미지를 보기 위한 url
    return send_file(static_dir + 'sample.jpg', mimetype='image/gif')


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
