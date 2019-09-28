import glob
import json
import numpy

from PIL import Image

with open("request.json", "w") as file:
    for img in glob.glob("*.png"):
        print(img)
        img = Image.open(img)
        values = numpy.asarray(img) / 255.0
        instances_data = {"myInput": values.ravel().tolist()}
        file.write(json.dumps(instances_data) + '\n')

