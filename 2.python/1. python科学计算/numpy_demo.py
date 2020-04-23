# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import os
import pandas as pd

os.chdir("G:\\git\\notebooks\\codes\\python")

fname = "train.csv"
df = pd.read_csv(fname, index_col = "Loan_ID") # 索引列 Loan_ID

# 布尔索引
df1 = print(df.loc[(df["Gender"] == "Female") & (df["Education"] == "Not Graduate") & (df["Loan_Status"] == "Y")], ["Gender", "Education", "Loan_Status"])
print(df.loc[(df["Gender"] == "Female") & (df["Education"] == "Not Graduate") & (df["Loan_Status"] == "Y")], ["Gender", "Education", "Loan_Status"])

# Apply函数
def num_missing(x):
    return sum(x.isnull())

print("Missing values per column:")
print("num_missing")
print(df.apply(num_missing))
print("num_missing2")
print(df.apply(num_missing, axis = 0))
print("num_missing3")
print(df.apply(num_missing, axis = 0).head())
print(df.apply(num_missing, axis = 1))
print(df.apply(num_missing, axis = 1).head())


# 补充缺失值
from scipy.stats import mode
#print(mode(df["Gender"]).mode[0])


# pivlot_table
import numpy as np
stat_r = df.pivot_table(values=["LoanAmount"], index = ["Gender", "Married", "Self_Employed"], aggfunc = np.mean)


# Crosstab
df_cross = pd.crosstab(df["Credit_History"], df["Loan_Status"], margins = True)
print(df_cross)

def percConvert(ser):
    return ser / float(ser[-1])

print(df_cross.apply(percConvert, axis = 1))