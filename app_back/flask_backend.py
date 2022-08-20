import os
from PIL import Image
import io
from flask import Flask, Blueprint, request, render_template, jsonify, Response, send_file
import jsonpickle
import numpy as np
import json
import base64
import detect as od

app = Flask(__name__)
static_dir = 'data/images/'
r = request.method


@app.route('/api', methods=['GET', 'POST'])
def model():
    if r == "GET":
        with open("../text/data.json") as f:
            data = json.load(f)
        return data
    elif r == 'POST':
        with open(static_dir + 'fuckyes.jpg', "wb") as fh:
            fh.write(base64.decodebytes(request.data))
        # captions = gc.generate_captions(static_dir + 'fuckyes.jpg')
        # captions = ic.~(static_dir + 'fuckyes.jpg)
        od_opt = od.parse_opt()
        od.main(od_opt)
        with open('./runs/detect/exp/fuckyes.jpg', 'rb') as img:
            detections = base64.b64encode(img.read())
        # model_result = {"captions": captions, "detections": detections}
        model_result = {"detections": detections}
        with open("text/data.json", "w") as fjson:
            json.dump(model_result, fjson)
    else:
        return jsonify({
            "captions": "Refresh again !"
        })


@app.route('/result')
def sendimage():
    return send_file(static_dir + 'fuckyes.jpg', mimetype='image/gif')


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
