# Pyspark数据分析 cookbook

## 基本概念
1. 数据结构

## 数据操作

### Read data

1. 数据导入 \ 数据生成

2. 导出数据

   sdf.write.csv("xxx.csv", mode="overwrite")

3. 数据展示及格式化展示

### Data ETL

4. 显示所有列名

   df.columns # 和python一样

5. 数据筛选

   - df.filter df.where              # 筛选行
     - sdf_sample.filter(sdf_sample.gender == "male")

   - df.select(df.var, df.var2, ...) # 筛选列

5. 数据清洗

   - 数据类型修改

   - 空值填充

   - 生成列  sdf = sdf.withColumn("weight", when(sdf.y_label==1, 1).otherwise(100))


6. 抽样

   - 简单抽样 sdf_sample.sample(False, weight_ratio, seed) # False为无放回抽样，True为有放回抽样， weight_ratio样本权重的倒数，seed为抽样种子

   - 

7. 样本合并

   - 生成空的dataframe

     ```
     from pyspark.sql.types import StructType, StructField, StringType, IntegerType
     
     # 定义模式，列名为 name 和 age，数据类型分别为字符串和整型
     schema = StructType([StructField("name", StringType(), True), StructField("age", IntegerType(), True)])
     
     # 生成一个空的 RDD
     empty_rdd = spark.sparkContext.emptyRDD()
     
     # 使用 createDataFrame() 方法生成空的 DataFrame
     empty_df = spark.createDataFrame(empty_rdd, schema)
     
     # 显示 DataFrame 的内容
     empty_df.show()
     ```

     

   - 合并行

     `df = df1.union(df2)`

   - 合并列

     ```python
     # 定义两个 DataFrame
     df1 = spark.createDataFrame([(1, "Alice"), (2, "Bob"), (3, "Charlie")], ["id", "name"])
     df2 = spark.createDataFrame([(1, "New York"), (2, "Los Angeles"), (4, "Chicago")], ["id", "city"])
     
     # 将两个 DataFrame 合并
     df = df1.join(df2, "id", "left_outer")
     
     # 显示合并后的 DataFrame 的内容
     df.show()
     ```

     

### Data Stat \ 数据统计

1. 表大小

   df.count().show()

2. 单列去重统计

   对column_name列进行枚举计数，并按照计数结果的大小排序

   df.groupBy("column_name").count().orderBy("count", ascending=False).show()

3. 透视表

   df.groupBy("name").pivot("month").sum("sales")

4. 

## 函数

### for

```
sql_list = [f"select * from survey_db.{table}" for table in table_array]
for sql in sql_list:
    df = spark.sql(sql)
    df.show()
```

### map 实现遍历

```pyspark
# 生成整数序列并遍历
def process_number(num):
    num_plus_one = num + 1
    return num_plus_one

result = spark.range(1, 10).rdd.map(process_number).collect()
print(result)
```



### date dealer

1. integer to date

   [convert sting to Date data type in spark sql](https://learn.microsoft.com/en-us/answers/questions/509162/convert-sting-to-date-data-type-in-spark-sql.html)

   ```sql
    to_date("20220101","yyyyMMdd")
   ```

2. date segements: year month day

   ​	month(to_date("20220101","yyyyMMdd"))

3. dateformat

   date_format(to_date("20220101","yyyyMMdd")， "yyyy-MM")
