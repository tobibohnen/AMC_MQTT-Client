FROM --platform=linux/arm/v7 arm32v7/python:latest
COPY app.py /app.py
CMD python3 app.py
