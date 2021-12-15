# set base image (host OS)
FROM arm32v7/python

# install dependencies
RUN pip install paho-mqtt

# copy the content of the local src directory to the working directory
COPY src/app.py /app.py

# command to run on container start
CMD [ "python", "./app.py" ]
