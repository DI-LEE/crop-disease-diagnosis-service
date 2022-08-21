import sys
from flask import Flask, request, jsonify, send_file
import json
import base64
import object_detection.detect as od

sys.path.insert(0, '/home/ubuntu/projects/crop-disease-diagnosis-service')

app = Flask(__name__)
static_dir = 'object_detection/data/images/'
data_path = '/home/ubuntu/projects/crop-disease-diagnosis-service/app_back/object_detection/data'


@app.route('/api', methods=['GET', 'POST'])
def model():
    r = request.method
    if r == 'GET':
        with open(data_path + "/data.json") as f:
            data = json.load(f)
        return data
    elif r == 'POST':
        with open(static_dir + 'fuckyes.jpg', "wb") as fh:
            fh.write(base64.decodebytes(request.data))
        # captions = gc.generate_captions(static_dir + 'fuckyes.jpg')jm,
        # captions = ic.~(static_dir + 'fuckyes.jpg)
        od_opt = od.parse_opt()
        od.main(od_opt)
        with open('object_detection/runs/detect/exp/fuckyes.jpg', 'rb') as img:
            detections = base64.b64encode(img.read())
        # model_result = {"captions": captions, "detections": detections}
        model_result = {"detections": detections}
        with open(data_path + "/data.json", "w") as fjson:
            json_result = json.dumps(model_result)
            fjson.write(json_result)
        return json_result
    else:
        return jsonify({
            "captions": "Refresh again !"
        })


@app.route('/result')
def sendimage():
    return send_file(static_dir + 'fuckyes.jpg', mimetype='image/gif')


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
