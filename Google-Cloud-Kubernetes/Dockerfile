# Use the official lightweight Python image.
# https://hub.docker.com/_/python
FROM python:3.7
# Copy local code to the container image.
ENV APP_HOME ./home
WORKDIR $APP_HOME
COPY . ./home
USER root
RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*

RUN sudo chown root:root *
RUN sudo chmod -R 777 ./home

RUN sudo apt-get update && sudo apt-get install -y apt-utils build-essential cmake && sudo apt-get install -y libgtk-3-dev && sudo apt-get install -y libboost-all-dev && sudo apt-get install -y default-libmysqlclient-dev

RUN pip install setuptools mysqlclient cmake python-Levenshtein Flask gunicorn pybase64 protobuf nltk fuzzywuzzy PyPDF2 numpy python-csv pandas SQLAlchemy PyMySQL pytz Unidecode torch tensorflow==2.0 transformers imutils scikit-learn scikit-image scipy==1.4.1 opencv-python text2num sklearn 
RUN pip install --upgrade google-cloud-vision
RUN pip install --upgrade google-cloud-language
RUN pip install --upgrade google-cloud
RUN pip install google-api-python-client==1.9.3
RUN pip install google-auth-oauthlib==0.4.1
RUN pip install google-cloud-storage

RUN sudo apt-get install python3-mysqldb
RUN pip install dlib
RUN python -c "import nltk;nltk.download('punkt');nltk.download('stopwords')"

COPY app.py ./home/app.py
COPY sentimentos_marco_en.txt ./home/sentimentos_marco_en.txt
COPY sentimentos_marco_es.txt ./home/sentimentos_marco_es.txt
COPY sentimentos_marco_pt-BR.txt ./home/sentimentos_marco_pt-BR.txt
COPY treino_labels.csv ./home/treino_labels.csv
COPY Temp.pdf ./home/Temp.pdf
COPY temp.jpeg ./home/temp.jpeg
COPY temp.jpg ./home/temp.jpg
COPY temp_face.jpg ./home/temp_face.jpg
COPY face_temp.png ./home/face_temp.png
COPY face_rubens.jpeg ./home/face_rubens.jpeg
COPY face_shape_predictor_68_face_landmarks.dat	./home/face_shape_predictor_68_face_landmarks.dat	
COPY haarcascade_frontalface_default.xml ./home/haarcascade_frontalface_default.xml

CMD ["python", "./home/app.py"]

