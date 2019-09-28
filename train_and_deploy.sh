#!/bin/bash

MODEL_BUCKET="your_mnist_bucket"
GCS_MODEL_PATH="gs://$MODEL_BUCKET/"
MODEL_NAME="your_mnist_model"
MODEL_DIR="model"
MODEL_VERSION="v0001"
TF_RUNTIME_VERSION="1.13"

# training and outpu SavedModel format model folder
python3 MnistSavedModel.py

# create your new bucket and upload your model into that bucket
gsutil mb -c multi_regional $GCS_MODEL_PATH
gsutil cp -r $MODEL_DIR $GCS_MODEL_PATH

# deploy to ai-platform
gcloud ai-platform models create $MODEL_NAME --regions us-central1
gcloud ai-platform versions create $MODEL_VERSION --model $MODEL_NAME --origin \
    "${GCS_MODEL_PATH}${MODEL_DIR}" \
    --runtime-version=$TF_RUNTIME_VERSION --python-version=3.5

