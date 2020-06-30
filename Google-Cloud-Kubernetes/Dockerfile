# Use the official lightweight Python image.
# https://hub.docker.com/_/python
FROM python:3.7

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*


RUN sudo apt-get update && sudo apt-get install -y apt-utils build-essential cmake && sudo apt-get install -y libgtk-3-dev && sudo apt-get install -y libboost-all-dev && sudo apt-get install -y default-libmysqlclient-dev
# Install production depython-csvpendencies.
RUN pip install setuptools mysqlclient cmake Flask gunicorn pybase64 google-cloud-vision google-cloud-storage protobuf nltk fuzzywuzzy PyPDF2 numpy python-csv google-cloud-language pandas SQLAlchemy PyMySQL pytz Unidecode torch tensorflow==1.15 transformers imutils scikit-learn scikit-image scipy==1.4.1 opencv-python text2num sklearn
RUN pip install dlib

# Run the web service on container startup. Here we use the gunicornpytiz 
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
COPY app.py ./app.py
COPY sentimentos_marco_en.txt ./sentimentos_marco_en.txt
COPY sentimentos_marco_es.txt ./sentimentos_marco_es.txt
COPY sentimentos_marco_pt-BR.txt ./sentimentos_marco_pt-BR.txt
COPY treino_labels.csv ./treino_labels.csv
COPY Temp.pdf ./Temp.pdf
COPY face_shape_predictor_68_face_landmarks.dat	./face_shape_predictor_68_face_landmarks.dat	
COPY haarcascade_frontalface_default.xml ./haarcascade_frontalface_default.xml
CMD ["python", "./app.py"]
