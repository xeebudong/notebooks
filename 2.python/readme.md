# Python 数据分析学习路线

> python作为一门数据分析利器，已经被应用到各行各业，资料也非常的成熟，市面上，有各种教授python的书籍、网络资源也非常丰富。笔者也是通过学习这些资料，才进入到python的开发阵营。市面上，刊发的书籍，少有从工程角度出发，去透视python在数据分析中的应用。通过本系列资料，读者可以很轻松的使用python去做数据清理、数据分析以及实现可视化。

## 库安装

1. [错误：pip install *:ERROR: Exception: Traceback (most recent call last)](https://blog.csdn.net/weixin_28927079/article/details/103726559)

   > 使用镜像安装，在pip install XXX 后面加上 -i https://pypi.douban.com/simple
   >
   > 例如：pip install cpca -i https://pypi.douban.com/simple

## 关于Python

1. Python优势

   - 效率

     > 多快(快速获得结果)好省(节约成本\时间成本)

   - 生产率

     > 多(相同资源配置下，完成更多的任务)快好省

   - 质量

     > 多快好(能做替代技术不能做的事情，且做好)省

2. Python性能瓶颈突破

   - 范型

     > 选择合适的方式，可以显著改善，如Numpy

   - 编译

     > 高性能库提供重要函数的编译版本，比较流行的高性能库有Cython、Numba
     >
     > 将Python代码静态或动态地编译为机器代码

   - 并行化

     > 并行计算

## 0. 数据I\O

> pandas在读取csv时，如果csv太大，可能会造成读取错误，有以下几种方式能解决

1. 忽略错误

- df = pd.read_csv(pth, encoding="utf-8", engine="python", error_bad_lines=False)
- 在读数代码中，加入error_bad_lines=False， 忽略错误行


2. Python获取csv的编码格式

> 使用detect来监测csv文件的编码格式，如果读入的数据较少，比如readline，可能无法检测到准确的编码格式；读入的数据越多，监测越准

```python
from chardet import detect

def get_encoding(pth):
    with open(pth, "rb+") as fp:
        content = fp.read(100000)
        encoding = detect(content)
    return encoding["encoding"]
```


3. 读入的数据太大时，会造成错误

- 设置chuncksize

## 1.Python 语法基础 

### 1. 变量、表达式、语句

- 查询变量类型 type(varname)

- 注释 #

- 类型检查

  ```python
  # 方法一 instance
  if not instance(n, int)
  
  # 方法二 issubdtype
  df = pd.DataFrame({'A': [1, 2, 3], 'B': [1.0, 2.0, 3.0], 
                     'C': [1j, 2j, 3j], 'D': ['a', 'b', 'c']})
  
  np.issubdtype(df['A'].dtype, np.number)
  ```

- 动态变量

  > 利用作用域来解决

  ```python
  names = locals() # 或者 names = vars()
  names["x_%d" %(1)] = 1
  print(x_1)
  ```

### 2. 赋值(魔法赋值)

> 注意copy与deepcopy
>
> 切片，可以达到深拷贝的效果

- 序列解包 多个赋值操作可以同步进行，这种操作叫序列解包

  > 当函数或者方法返回元组时(或者其他序列或可迭代对象)时，这个特性非常有用
  >
  > x, y, z = 1, 2, 3
  >
  > key, value = dic.popitem()

- 链式赋值 x = y = 1

- 增量赋值 x += 1

### 3. 条件判断

- if elif else

- == 

- is

- not 

- in

- 断言 

  > if语句非常有用的“近亲”，究竟为什么需要这样的代码呢？在需要确保程序中的某个条件一定为真才能让程序正常工作的话，assert语句就有用了，它可以在程序中置入检查点。

  ```
  age = -1
  assert 0 < age < 100
  ```

  

### 4. 循环

- while
- for
- **列表推导式** 轻量级循环
- 迭代工具
  - 并行迭代 for in
- 跳出循环
  - break
  - continue
  - while true break

### 5. 递归

> 汉诺塔 

### 6. 函数

- 参数 

  - 存储在局部作用域，入参一般情况下，不会被修改

  > 变量和形参都是局部变量
  
  > 在python中，我们无法改变参数，哪怕参数是引用参数【如果不是完全重新赋值，而是修改引用参数的其中的值，形参是会被改变的】
  >
  > ```python
  > lst = [1, 2, 3]
  > 
  > def ch(lst): # 不改变入参
  >     lst = [2]
  >     return lst
  > 
  > def ch2(lst): # 改变入参， Tips，将值放在列表中，是可以改变入参的
  >     lst[0] += 1
  >     return lst
  > 
  > lst
  > ch(lst)
  > lst
  > ch2(lst)
  > lst
  > ```

  - 关键字参数 参数顺序不好记

  - 默认参数 从最右边开始放起

  - 收集参数 *
  
    > 有时候，我们想让用户提供任意数量的参数都是有用的, *号的意思就是收集其余位置的参数
    >
    > def print_params(*params):
    >
    > ​     print(params)
    >
    > print_params(1, 2, 3, 4, 5)

  - 收集关键字参数 ** 

    > 作用和*类似，但是可用于搜集关键字参数
  
    ```python
    def print_params(x, y, z, *pospar, **keypar):
        print(x, y, z)
        print(pospar)
        print(keypar)
        
    print_params(1, 2, 3, 4, 5, 6, foo=1, bar=2)
    ```

  - \* 和 \*\* 在调用时也可以使用
  
    ```python
    # 上文，讲了如何将参数收集为元祖和字典，即在参数中如何收集元组和字典；实际上，在调用时也可以用* 和 ** 来获得入参
    
    def add(x, y):
        return x+y
        
    params = (1, 2)
    add(*params)
    ```

> 

### 7. 栈图 Stack Diagrams

> 为了跟踪哪个变量能去哪儿用，有时画一个栈图(Stack Diagrams)比较有用，像状态图一样，栈图显示每个变量的值，但是他们也展示了每个变量属于的函数

### 8. 作用域

> 到底什么是变量？
>
> - 值的名字
> - 在执行赋值语句后，名称x引用到值，这就像用字典一样，键引用了值
> - 变量和所对应的值用的是个”不可见“的字典，这个不可见的字典叫做命名空间或者作用域
> - 有多少作用域呢？除了全局作用域，每个函数都会创建一个新的**作用域**
> - 局部变量 vs 全局变量

```
x = 1
scope = vars()
scope["x"] += 1
x
```

- 重绑定global， 告诉局部作用于变量为全局变量

  > 在函数内部访问全局变量 global

  ```python
  x = 1
  
  def test(parameter):
      # global x
      x += 1
      return x
  
  print(test(2))
  ```

- globals()

  > 如果在函数内容，想要访问的全局变量和局部变量或者形参重名，全局变量是会被覆盖的，如果确实需要的话，可以使用globals函数获取全局变量值，该函数的近亲是vars()， 可以返回全局变量字典

### 9. 函数式编程

- lambda

- apply \ applymap

  - apply, 		对单列/多列处理，可传入参数
  - applymap 针对cell

- map\reduce\filter

  - map(func, seq) 对单列处理，对序列中的每个元素引用函数

  ```
  # map(function, squence)	返回sequence执行function后的值
  s = [1,2,3,4,5,6]
  print(list(map(lambda x: x%2 == 1, s)))
  ```

  - reduce(func, seq) 返回一个单值，它是这样构造的：首先以序列的前两个元素调用函数function，再以返回值和第三个参数调用，依次执行下去。例如，以下程序计算 1 到 10 的整数之和

  > *Python3.x reduce() 已经被移到 functools 模块里，如果我们要使用，需要引入 functools 模块来调用 reduce()* 

  - filter(func, seq) 返回其函数为镇的元素的列表

  ```python
  from functools import reduce
  lst = [1, 2, 3, 4]
  
  print(list(map(lambda x:x+1, lst)))
  print(list(filter(lambda x:True if x>2 else False, lst)))
  print(reduce(lambda x, y:x+y, lst))
  ```

### 10. 几个关键字

- pass
- del 删除的只是名称，而不是对象本身【实际上，python是没办法删除对象的，因此引用赋值，原名称的引用对象是不会删除的】
- exec 执行动态代码，不返回结果，因为本身就是语句 exec("print(1+2)")
- eval 会计算输入的表达式，并返回结果  eval("1+2+3")
- globals() 、 vars()

## 2. Python数据结构

> collections是Python内建的一个集合模块，提供了许多有用的集合类

> import collections
>
> from collections import Counter

1. 查看collections中所有的数据结构

   ```python
   import collections
   collections.__all__
   ```

   > ['deque', 'defaultdict', 'namedtuple', 'UserDict', 'UserList', 'UserString', 'Counter', 'OrderedDict', 'ChainMap']

2. 各数据结构

   | 数据结构    | 名称         | 功能                        |
   | ----------- | ------------ | --------------------------- |
   | deque       |              |                             |
   | defaultdict |              |                             |
   | namedtuple  |              |                             |
   | UserDict    |              |                             |
   | UserList    |              |                             |
   | UserString  |              |                             |
   | Counter     | 统计对象频次 | element<br>most_common([n]) |
   | OrderDict   |              |                             |
   | ChainMap    |              |                             |


### 1. 列表

> 切片，是一种很有效率的复制整个列表的方法

- 方法
  - append 末尾追加新对象
  - count 统计元素在列表中出现的次数
  - extend 在末尾一次性追加多个元素
  - index 找出第一个匹配值的位置
  - insert(idx, value) 在特定位置idx插入元素value
  - pop 删除最后一个元素
  - remove 删除匹配的第一个元素
  - reverse 列表逆序
  - sort 原位置排序

### 2. 元组

- tuple 列表转元组
- list 元组转列表

### 3. 字符串

- 正则表达式，另附

- 方法

  - find 返回最左端索引，如果没有则为-1

  - join 

  - lower\upper 

  - endswith / startswith

  - split

  - strip/lstrip/rstrip

  - replace 

  - translate 与replace类似，不同的是translate只替换单个字符，但是可以多个一起，translate的入参为maketrans
  
    ```
    # from string import maketrans
    tbl = str.maketrans("cs", "kz")
    
    str = "I am a chinese"
    str.translate(tbl)
    ```
  
    ![image-20210727174117220](E:\notebooks\2.python\0. 资料\maketrans.txt)

### 4. 字典

- 创建字典 dict
- 基本操作
  - len
  - d[k]
  - d[k] = v
  - del d[k]
  - k in d / k in d.keys() / k in d.values() 检查d中是否含有健为k的项 / 检查d中是否有值为k
- 方法
  - clear 清除字典所有的项
  - copy
  - fromkeys
  - get 键值不存在时，不会有异常情况
  - setdefault 与get类似，但可设定在键值不存在时，返回的值
  - has_key
  - items / iteritems
  - keys / iterkeys
  - values / itervalues
  - pop 移除指定键值的项，如果没有返回错误
  - popitem 不加参数，随机移除项
  - updte 用一个字典更新另一个字典

### 5. 集合、堆、双端队列

> 参考面向对象 > 标准包

## 3. Python 面向对象

### 1. 多态 封装 继承

- 多态 可以对不同类的对象使用同样的操作，他们会执行各自的对应的操作，例如叫声，所有动物都有叫声，但叫法各有不同
- 封装 对外部世界隐藏对象的工作细节
- 继承 以普通的类为基础建立专门的类对象

### 2. 类和类型

- 构造函数

- super函数

- property函数

  > property函数，使对象看起来像普通的属性

- 基本的序列映射规则

  - \__len__
  - \__getitem__
  - \__setitem__
  - \__delitem__

- \__getattr__, 属性attr被访问时，自动调用

- \__setattr__

- \__delattr__

```python
class Person:
    def __init__(self, name, age): # 构造函数
        self.name  = name
        self.__age = age    ## 带双下划线，意思为private，相当于年龄是私有的，不能直接获得
        
pr = Person("Lulu", 21)
pr.name
pr.__age # 会报错
```

### 3. 特性、函数、方法

> 双下划线，类似于其他语言标准的私有方法

### 4. 类的命名空间

> 类定义，其实就是执行代码块，在类的定义区并不只限定使用def语句
>
> 类作用域内的变量也可以被所有实例访问

### 5. 超类、接口、内省

- 接口，用于实现多态

### 6. 迭代器 生成器(yield)

> def \__iter__()， 使类可迭代

### 7. 模块与包

> 模块是程序，任何程序都可以作为模块
>
> 包就是模块的目录

- 引入模块

  import sys

  sys.path.append("dir") # 引入模块所在地址

- 探究模块

  - dir 查看模块包含的内容，会将对象(函数、类、变量)均列出来
  - \_\_all\_\_ 在使用 from pandas import * 时，   \__all__ 限定了能import进来的对象，不然都会被引入进来
  - help

  ```
  import pandas as pd
  
  dir(pd)
  pd.__all__
  
  ```

### 8. 标准包(随机数等)

- 集合 set
  
- 交集 \ 差集 \ 异集
  
- 堆 heap

- 双端队列 deque

- **随机数生成器 random**

  - randrange([start, ] stop [, step]), 返回range(start, stop, step)中的随机数
  - choice(seq) 从序列seq中返回随机元素
  - shuffle(seq) 原地指定seq顺序
  - sample(seq, n) 随机抽样

  ```
  import random
  lst = range(1, 100)
  lst2 = [1, 2, 3, 4, 5, 6, 7]
  
  random.choice(lst)
  random.shuffle(lst2)
  lst2
  
  random.sample(lst, 2)
  ```

- shelve 存储包

  ```python
  import shelve
  
  s = shelve.open(r"C:\Users\alywi\Desktop\hello.dat") # 存储
  s["x"] = [1, 2, 3]
  s["y"] = [3, 2]
  
  
  d = shelve.open(r"C:\Users\alywi\Desktop\hello.dat") # 使用
  d["x"]
  ```

  

- 

### 总结

- issubclass 查询是否是子类

- > 名字，可能抽象为类
  >
  > 动词，可能抽象为方法
  >
  > 形容词，可能抽象为特性

## 4. 异常

### 1. 什么是异常

> Exception，表示异常情况，遇到程序错误时，会引发异常
>
> 如果异常对象未被处理或捕捉，程序就会用所谓的回溯Traceback终止执行

- raise Exception
- 常见异常
  - ZeroDivisionError 除数为0
  - ValueError
  - IndexError
  - KeyError

### 2. 自定义异常类

> class selfException(Exception):
>
> ​    pass

### 3. 捕获异常(异常的使用)

> try / except / else

```python
try:
    x = 1/0
except ZeroDivisionError:
    print("The second number is zero")
else:
    print("error is not raised")
```



## 5. 正则表达式 re

> 另附文件

## 6. Python 科学计算 

### 1. Numpy

- **np.where 三元表达式**

  > x if condition else y
  > '''
  > arr1 = np.arange(5)
  > arr2 = np.arange(20, 25)
  > condition = np.array([0, 1, 0, 0, 1])
  > result = np.where(condition, arr1, arr2)
  > print(arr1)
  > print(arr2)
  > print(result)
  > '''

- 集合运算
  - unique
  - intersect1d
  - union1d
  - in1d
  - setdiff1d
  - setxor1d

- 

## Python 可视化

1. [将多张表格绘制到一起并输入到pdf中](https://www.zhihu.com/question/68489126/answer/334893776)

## Python 高级话题

## Python 全栈开发

### Flask

1. [Python爬取疫情实战：Flask搭建web/Echarts可视化大屏/MySQL数据库/Linux项目部署与任务定时调度](https://www.bilibili.com/video/BV177411j7qJ?p=13)
2. Project > flask

   

## Python库

> [一文总结数据科学家常用的Python库](https://mp.weixin.qq.com/s?__biz=MzIyNjM2MzQyNg==&mid=2247485540&idx=1&sn=9703edaa804a1bfe3e230dfc54f40fca&chksm=e870d929df07503fc4a1bf14179da438159ea5d6d0a523823f47b49d6d7e11ff9f421aabc611&mpshare=1&scene=2&srcid=08298gs54sZ0f7LHVLktk9Yy&sharer_sharetime=1567091241514&sharer_shareid=ea22174a42a784e476cef382274c0236&from=timeline&clicktime=1567093641&key=d9f1c9604021247bc39b6f22e2a360cd525da9cc2cba4679a06f69f1380306a546f575d5cc0958c3339bf04bad06740fe71712c13eba64451bf45c1b944a90200235453e19a00e17f458a5170c6e0232&ascene=14&uin=MjAxNzI2NDMwMA%3D%3D&devicetype=Windows+10+x64&version=62090070&lang=zh_CN&exportkey=AeyZCHB22Lbtkzrk7qv3hH0%3D&pass_ticket=PiIpvy%2Fe%2BYAbbsabsxPBQg5g1N49emRI2yq6eBiN7DOZCXYgvnaKbjXuwrFZ1ovV)

<table>
    <tr>
        <td>科学计算</td>
        <td>Pandas<br>PyOD<br>Numpy<br>Spacy</td>
    </tr>   
    <tr>
        <td>数据结构</td>
        <td>collections</td>
    </tr>   
    <tr>
        <td>数据可视化</td>
        <td>Matplotlib<br>Seaborn</td>
    </tr>   
    <tr>
        <td>建模库</td>
        <td>Scikit-Learn<br>TensorFlow<br>PyTourch</td>
    </tr>
    <tr>
        <td>模型解释库</td>
        <td><a href="https://zhuanlan.zhihu.com/p/75307392">Lime</a><br>H2O</td>
    </tr>
    <tr>
        <td>数据库</td>
        <td>Psycopg<br>SQLAlchemy</td>
    </tr>
</table>
## 参考资料

1. [Python API 文档](https://docs.python.org/zh-cn/3.7/library/index.html)
3. [想用Django+ Bootstrap写一个网站， 有哪些比较系统完整的书或者视频可以参考？](https://www.zhihu.com/question/29804463#answer-13798033)
4. [如何发布自己的Python库](https://zhuanlan.zhihu.com/p/66603015)
4. [提高数据的颜值！一起看看Pandas中的那些Style](https://zhuanlan.zhihu.com/p/126223075)
5. [用Python快速自动生成图文并茂的PDF文件](https://zhuanlan.zhihu.com/p/318390273)
6. Python基础教程(第二版)， Magnus Lie Hetland，人民邮电出版社 【对初学者不友好，艰涩】

