# Pyspark数据分析 cookbook

## 基本概念
1. 数据结构


## 数据操作
1. 数据导入 \ 数据生成


2. 数据展示及格式化展示

3. 数据统计 
- 单列去重统计
- 透视表


4. 数据筛选
- df.filter df.where              # 筛选行
- df.select(df.var, df.var2, ...) # 筛选列

sdf_sample.filter(sdf_sample.gender == "male")

5. 数据清洗
- 数据类型修改
- 空值填充
- 生成列  sdf = sdf.withColumn("weight", when(sdf.y_label==1, 1).otherwise(100))


6. 抽样
- 简单抽样 sdf_sample.sample(False, weight_ratio, seed) # False为无放回抽样，True为有放回抽样， weight_ratio样本权重的倒数，seed为抽样种子
- 

7. 样本合并
- df1.union(df2)

8. 导出数据
   - sdf.write.csv("xxx.csv", mode="overwrite")
9. 

## 函数
