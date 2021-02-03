# Python制作安装包 
> 总共三步完成

1. 创建类文件，文件命名为Calculation

```
class Calculation():
    def _init_(self, a, b):
        self.a = a
        self.b = b
        
    def add(self):
        return self.a+self.b
    
    def sub(self):
        return self.a-self.b
```

2. 写打包脚本
```
from setuptools import setup

setup(
    name='Calculation',
    version='V0.1',
    packages=['cals'],
    license='''
        Creative Commons 
        Attribution-Noncommercial-Share Alike license''',
    long_description='''
        An example of how to package code''', 
    author="author", 
    author_email="author@gmail.com"
)
```

文件结构如下：

setup.py
cals文件夹
    |- Calculation.py

3. 运行打包脚本

在setup.py所在文件夹下，doc窗口运行：

- python setup.py sdist.tar, 将打包安装包成tar包
- python setup.py install， 会安装包



# 参考
1. [python制作安装包](https://www.bbsmax.com/A/pRdBZ4o6dn/)
2. [Getting Started With setuptools and setup.py](https://pythonhosted.org/an_example_pypi_project/setuptools.html)