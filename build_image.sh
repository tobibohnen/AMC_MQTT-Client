#!/bin/bash

docker rm tobias1172/amc_mender_pipeline
docker build -t tobias1172/amc_mender_pipeline .
docker push tobias1172/amc_mender_pipeline:latest
