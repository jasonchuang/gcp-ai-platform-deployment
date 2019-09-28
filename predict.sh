#!/bin/bash

MODEL_NAME="your_mnist_model"

pip3 install Pillow
python3 make_request.py
gcloud ai-platform predict --model ${MODEL_NAME} --json-instances request.json

