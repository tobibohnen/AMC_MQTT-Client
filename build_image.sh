#!/bin/bash

rm -f build/Dockerfile
mkdir build
cp app.py build/.
cp docker-artifact.mender build/.

echo "FROM --platform=linux/arm/v7 arm32v7/python:latest" >> build/Dockerfile

echo "RUN adduser -D myuser" >> build/Dockerfile
echo "USER myuser" >> build/Dockerfile
echo "WORKDIR /home/myuser" >> build/Dockerfile

echo "COPY --chown=myuser:myuser requirements.txt requirements.txt" >> build/Dockerfile
echo "RUN pip install --user -r requirements.txt" >> build/Dockerfile

echo "ENV PATH="/home/myuser/.local/bin:${PATH}"" >> build/Dockerfile

echo "COPY --chown=myuser:myuser app.py /app.py" >> build/Dockerfile

echo "CMD apk update" >> build/Dockerfile
echo "CMD apk upgrade" >> build/Dockerfile

echo "CMD apk add mosquitto" >> build/Dockerfile
echo "CMD apk add mosquitto-clients" >> build/Dockerfile

echo "COPY app.py /app.py" >> build/Dockerfile
echo "CMD python3 app.py" >> build/Dockerfile


cd build
docker rm tobias1172/amc_mqttclient
docker build -t tobias1172/amc_mqttclient .
docker push tobias1172/amc_mqttclient:latest
