#!/bin/sh

rm -rf ./python layer.zip
mkdir python
pip install -r requirements.txt -t ./python
zip -r9 layer.zip ./python
