#!/bin/bash

rm -f build/Dockerfile
mkdir build
cp app.py build/.
cp docker-artifact.mender build/.

echo "FROM python:3.11.0a3-alpine3.15" >> build/Dockerfile
echo "RUN pip install paho-mqtt" >> build/Dockerfile
echo "COPY app.py /app.py" >> build/Dockerfile
echo "CMD python3 app.py" >> build/Dockerfile

cd build
docker rm tobias1172/amc_mqttclient
docker build -t tobias1172/amc_mqttclient .
docker push tobias1172/amc_mqttclient:latest

