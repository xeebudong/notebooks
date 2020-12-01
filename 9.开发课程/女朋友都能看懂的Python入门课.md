# 参考

1. [廖雪峰的Python课](https://www.liaoxuefeng.com/wiki/1016959663602400/1017024645952992)

# Ch1. 环境配置

## 1. 安装环境 Anaconda  28min

> 熟悉 
>
> 1. Spyder
>
> 2. Jupyter
>
> ```python
> import seaborn as sns
> sns.set_theme(style="ticks")
> 
> df = sns.load_dataset("penguins")
> sns.pairplot(df, hue="species")
> ```
>
> 

[点击](https://repo.anaconda.com/archive/Anaconda3-2020.11-Windows-x86_64.exe)下载

# Ch2. Hello world

## 1. Python

> Python语言是什么语言
>
> - 一切皆对象：函数、数据类型等都为对象
> - 无数据类型定义

## 2. Python 要素

- 头文件
- main函数
- 函数
- 变量

## 3. 基本数据结构

- 数据类型和变量
- 字符串与编码
- list、tuple
- dict、set

## 4. 基本语法

- 数据运算： + - * /
- 字符串运算：字符串拼接、字符串的截取
- 条件判断
- 循环
  - for
  - while
  - break
  - continue

## 5. Demo

```python
def rank(score):
    if score>90:
        rnk = 'A'
    elif score > 80:
        rnk = 'B'
    elif score > 60:
        rnk = 'C'
    elif score <= 60:
        rnk = 'D'
    else:
        rnk = 'Other'
    return rnk
        
if __name__ == "__main__":
    rank(91)
    rank(65)
```



# Ch3. 函数 - Function

## 1. 定义函数

def func(params):

​	return result

## 2. 参数

## 3. 调用函数

## 4. 递归函数

# Ch4. 高级特性

## 1. 切片

## 2. 迭代

> 判断对象是否可迭代
>
> ```
> from collections import Iterable
> isinstance('ABC', Iterable)
> ```

## 3. 列表生成式

> 循环太繁琐，而列表生成式则可以用一行语句代替循环生成上面的list

## 4. 生成器

> 1. 另一种形式的列表生成式，边循环边计算，和列表生成式的区别在于，使用()生成，使用next获得下一个元素
> 2. 加上yield, 普通函数变成 generator

## 5. 迭代器

> 可以被`next()`函数调用并不断返回下一个值的对象称为迭代器：`Iterator`。

# Ch5. 函数式编程

## 1. 返回函数

> 函数作为返回值

## 2. 高阶函数

### map / reduce

### filter

### sorted

## 3. 匿名函数

## 4. 装饰器

## 5. 偏函数



