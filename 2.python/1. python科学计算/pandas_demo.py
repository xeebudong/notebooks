# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import os
import pandas as pd
import numpy as np

os.chdir("G:\\git\\notebooks\\python\\python_code")

# Series
d1 = {"A":1, "B":2, "C":3}
d2 = {"A":5, "B":2, "D":6}

obj1 = pd.Series(d1)
obj2 = pd.Series(d2)

# 自动对齐不同索引
print(obj1 + obj2)


# DataFrame
d3 = {'A':{2001:2, 2002:3}, 'B':{2007:2, 2009:4}}
pd1 = pd.DataFrame(d3)

# 重新索引
index = pd.Index([2001, 2002, 2003, 2006])
pd1 = pd1.reindex(index, method = "ffill")
print(pd1)

#import pandas.io.data as web
from pandas_datareader import data, wb
all_data = {}

for ticker in ["AAPL", "IBM"]:
    all_data[ticker] = wb.get_data_yahoo(ticker, '1/1/2000', '2/5/2000')

