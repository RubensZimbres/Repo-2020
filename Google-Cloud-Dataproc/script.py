# from https://github.com/RubensZimbres/Repo-2019/blob/master/Spark/SPARK_ML.ipynb

import os
os.system('sudo apt install python3-pip | pip3 install google-cloud-storage pandas numpy datetime')
import subprocess
import sys

import re
import time

from pyspark import SparkConf
from pyspark import SparkContext
from pyspark import SQLContext
import pyspark.sql.functions as F
from pyspark.sql.functions import concat, col, udf, lag, date_add, explode, lit, unix_timestamp
from pyspark.sql.functions import month, weekofyear, dayofmonth
from pyspark.sql.types import *
from pyspark.sql.types import DateType
from pyspark.sql.dataframe import *
from pyspark.sql.window import Window
from pyspark.sql import Row
from pyspark.ml.classification import *
from pyspark.ml.feature import StringIndexer, OneHotEncoder, VectorAssembler, VectorIndexer
from pyspark.ml.feature import StandardScaler, PCA, RFormula
from pyspark.ml import Pipeline, PipelineModel
from pyspark.sql.functions import col, avg
#import argparse
#parser = argparse.ArgumentParser(description='')
#parser.add_argument('--input', dest='input', type=str)
#parser.add_argument('--output', dest='output', type=str)
#args = vars(parser.parse_args())

from pyspark import sql, SparkConf, SparkContext

conf = SparkConf().setAppName("Read_CSV")
sc = SparkContext(conf=conf)
sqlContext = sql.SQLContext(sc)

from google.cloud import storage
storage_client = storage.Client()
bucket = storage_client.get_bucket('gcp-end-to-end')
blob = bucket.blob('DadosTeseLogit.csv')
blob.download_to_filename('DadosTeseLogit.csv')

dataFile = "DadosTeseLogit.csv"
dataFileSep = ','
df = sqlContext.read.csv(dataFile, header=True, sep=dataFileSep, inferSchema=True, nanValue="", mode='PERMISSIVE')

df.count(), len(df.columns)

df.show(1)

df.dtypes

df = df.dropna(how='any')

def fill_with_mean(df, exclude=set()): 
    stats = df.agg(*(
        avg(c).alias(c) for c in df.columns if c not in exclude
    ))
    return df.na.fill(stats.first().asDict())

fill_with_mean(df, ["c0_preco"])

from pyspark.sql.types import *

df.createOrReplaceTempView("df1")

sqlStatement = """
    SELECT c0_atencao, c0_esperado, c0_preco FROM df1 WHERE df1.selected=='1'
"""
plotdata = sqlContext.sql(sqlStatement).toPandas();

df.groupby('c0_atencao').count().show()

import pyspark.sql.functions as F
import time
import pandas as pd
import subprocess
import sys
import os
import re
import numpy as np
import datetime

from pyspark import SparkConf
from pyspark import SparkContext
from pyspark import SQLContext
from pyspark.sql.types import *
from pyspark.sql.functions import col,udf,lag,date_add,explode,lit,concat,unix_timestamp,sum, abs
from pandas import DataFrame
from pyspark.sql.dataframe import *
from pyspark.ml.classification import *
from pyspark.ml.feature import VectorAssembler
from pyspark.sql.window import Window
from pyspark.sql.types import DateType
from pyspark.ml import Pipeline
from pyspark.ml.feature import StringIndexer, OneHotEncoder
from pyspark.ml.evaluation import *
from pyspark.ml.tuning import CrossValidator
from pyspark.ml.tuning import ParamGridBuilder
from pyspark.sql import Row
from pyspark.ml import Pipeline, PipelineModel
from pyspark.mllib.evaluation import BinaryClassificationMetrics
from pyspark.ml.feature import OneHotEncoder, StringIndexer, VectorIndexer, RFormula
from pyspark.ml.tuning import CrossValidator, ParamGridBuilder
from sklearn.metrics import roc_curve,auc
from pyspark.sql.functions import month, weekofyear, dayofmonth
from pyspark.ml.feature import ChiSqSelector
from pyspark.ml.linalg import Vectors
from pyspark.ml.feature import StandardScaler
from pyspark.ml.feature import PCA
from pyspark.ml.feature import MinMaxScaler
from pyspark.sql.types import DoubleType
from pyspark.ml.classification import RandomForestClassifier
from pyspark.ml.evaluation import MulticlassClassificationEvaluator
from pyspark.ml.classification import GBTClassifier
from sklearn.metrics import precision_recall_fscore_support as score
from sklearn.model_selection import GridSearchCV
from sklearn.model_selection import ParameterGrid
from pyspark.ml import Pipeline
from pyspark.ml.classification import RandomForestClassifier
from pyspark.ml.feature import IndexToString, StringIndexer, VectorIndexer
from pyspark.ml.evaluation import MulticlassClassificationEvaluator

df.select('c0_recomend').describe().show()

df.groupby('selected').count().show()

input_features=df.columns[2:28]
y=df.columns[30]
label_var = ['selected']

va = VectorAssembler(inputCols=(input_features), outputCol='features')

va2 = VectorAssembler(inputCols=([y]), outputCol='label')

df = va.transform(df)
df2 = va2.transform(df.withColumn("selected",df["selected"].cast("int")))

featureIndexer = VectorIndexer(inputCol="features", 
                               outputCol="indexedFeatures", maxCategories=10).fit(df)

labelIndexer = StringIndexer(inputCol="selected", outputCol="indexedLabel").fit(df2)

(trainingData, testData) = df.randomSplit([0.7, 0.3])

rf = RandomForestClassifier(labelCol="indexedLabel", featuresCol="indexedFeatures", numTrees=10)

labelConverter = IndexToString(inputCol="prediction", outputCol="predictedLabel",
                               labels=labelIndexer.labels)

pipeline = Pipeline(stages=[labelIndexer, featureIndexer, rf, labelConverter])

model = pipeline.fit(trainingData)

predictions = model.transform(testData)

predictions.coalesce(1).write.format('json').save('./output')

predictions.groupby('indexedLabel', 'prediction').count().show()

predictionAndLabels = predictions.select("indexedLabel", "prediction").rdd
metrics = BinaryClassificationMetrics(predictionAndLabels)
print("Area under ROC = %g" % metrics.areaUnderROC)
print("Area under PR = %g\n" % metrics.areaUnderPR)

evaluator = MulticlassClassificationEvaluator(labelCol="indexedLabel", predictionCol="prediction")
print("Accuracy = %g" % evaluator.evaluate(predictions, {evaluator.metricName: "accuracy"}))
print("Weighted Precision = %g" % evaluator.evaluate(predictions, {evaluator.metricName: "weightedPrecision"}))
print("Weighted Recall = %g" % evaluator.evaluate(predictions, {evaluator.metricName: "weightedRecall"}))
print("F1 = %g" % evaluator.evaluate(predictions, {evaluator.metricName: "f1"}))

