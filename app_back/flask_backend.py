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
    if r == 'GET':
        with open(data_path + "/data.json") as f:
            data = json.load(f)
        return data
    elif r == 'POST':
        with open(static_dir + 'sample.jpg', "wb") as fh:
            fh.write(base64.decodebytes(request.data))
        od_opt = od.parse_opt()
        od.main(od_opt)
        with open('object_detection/runs/detect/exp/sample.jpg', 'rb') as img:
            detections = base64.b64encode(img.read())
        captions = " ".join(gc.generate_captions(static_dir + 'sample.jpg')[0])
        model_result = {"captions": captions, "detections": detections.decode()}
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
    return send_file(static_dir + 'sample.jpg', mimetype='image/gif')


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
