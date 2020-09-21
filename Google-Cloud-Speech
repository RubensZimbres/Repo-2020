ffmpeg -i ./audio_in.wav -ac 2 -ab 128k -filter:a volume=0.95 -filter:a equalizer=f=4000:t=h:w=1:g=-5 -filter:a dynaudnorm audio_norm.wav

ffmpeg -i audio_norm.wav -af silenceremove=1:0:-50dB output.mp3

%reset

# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import time
start=time.time()

import io
import os

from google.cloud import speech_v1p1beta1 as speech
from google.cloud.speech_v1p1beta1 import enums
from google.cloud.speech_v1p1beta1 import types

#! pip install --upgrade google-cloud-storage
#! pip install webapp2
#! pip install cloudstorage
#! pip install GoogleAppEngineCloudStorageClient

from google.cloud import storage

client = storage.Client()


from google.cloud import speech_v1p1beta1 as speech

client = speech.SpeechClient()

config = speech.types.RecognitionConfig(
    encoding=enums.RecognitionConfig.AudioEncoding.MP3,
    sample_rate_hertz=8000,enable_word_time_offsets= True,
    model='default',
    language_code='pt-BR',
    enable_automatic_punctuation= True,
    use_enhanced=True,
    speech_contexts=[speech.types.SpeechContext(phrases=[, 'banco','protocolo','saque','depósito','dinheiro','caixa','valor'])],
    enable_speaker_diarization=True,
    diarization_speaker_count=3,
    audio_channel_count=1,
    profanity_filter=True,
    enable_separate_recognition_per_channel=False)

audio=speech.types.RecognitionAudio(uri="gs://platform666/output.mp3")

operation = client.long_running_recognize(config, audio)

print('Waiting for operation to complete...')
response = operation.result(timeout=420)
len(response.results)

linhas=[]
trans=[]

for result in response.results:
    # First alternative has words tagged with speakers
    alternative = result.alternatives[0]
    trans.append("Transcript: {}".format(alternative.transcript))
    # Print the speaker_tag of each word
    for word in alternative.words:
        linhas.append([word.word,word.speaker_tag])

linhas[200:]


from google.protobuf.json_format import MessageToJson
serialized = MessageToJson(response)
with open('/home/theone/transcript.json', 'w') as json_file:
    json.dump(serialized, json_file)

########################
        
speaker0=[]        
speaker1=[]        
speaker2=[]        
        
for result in response.results:
        # First alternative has words tagged with speakers
        alternative = result.alternatives[0]
        print(u"Transcript: {}".format(alternative.transcript))
        # Print the speaker_tag of each word
        for word in alternative.words:
            if(word.speaker_tag == 0):
                speaker0.append(word.word)
            elif(word.speaker_tag == 1):
                speaker1.append(word.word)
            elif(word.speaker_tag == 2):
                speaker2.append(word.word)
            #print(u"Word: {}".format(word.word))
            #print(u"Speaker tag: {}".format(word.speaker_tag))
            
speaker0 = ' '.join(speaker0)
speaker2 = ' '.join(speaker2)
speaker1 = ' '.join(speaker1)
