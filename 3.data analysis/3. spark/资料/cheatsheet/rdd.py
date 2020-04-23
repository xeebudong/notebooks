# -*- coding: utf-8 -*-
"""
Created on Tue Jan  8 22:51:49 2019

@author: tobe
"""



import os
import sys

spark_home = os.environ.get('SPARK_HOME', None)
if not spark_home:
    raise ValueError('SPARK_HOME environment variable is not set')
sys.path.insert(0, os.path.join(spark_home, 'python'))
sys.path.insert(0, os.path.join(spark_home, 'python/lib/py4j-0.10.4-src.zip'))
comm=os.path.join(spark_home, 'python/lib/py4j-0.10.4-src.zip')
print ('start spark....',comm)
exec(open(os.path.join(spark_home, 'python/pyspark/shell.py')).read())

#1. 导入spark
from pyspark import SparkConf, SparkContext

def print_info():
    print(sc.version)
    print(sc.pythonVer)
    print(sc.master)
    print(sc.appName)
    print(sc.applicationId)
    print(sc.defaultParallelism)
    print(sc.defaultMinPartitions)
    print(str(sc.sparkHome))
    print(str(sc.sparkUser()))
    print("\n")

print_info()


#2. 设置spark context
sc.stop()
conf = (SparkConf().setMaster("local").setAppName("My app").set("spark.executor.memory", "1g"))
sc = SparkContext(conf = conf)
print_info()


#3. 导入数据
rdd = sc.parallelize([("a", 6), ("c", 8)]) # Parallelized Collections, 另外一种方式是读入external file， 使用sc.textFile

#4. 检索rdd infomation
# 基本信息
print(rdd.getNumPartitions())
print(rdd.count())
# 描述性信息
print(rdd.max())


#5. map











