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

## 1. Python 语法基础

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

   

## 3. Python 面向对象

## 4. Python 科学计算

### Pandas

1. map，对单列处理，类似于replace
2. apply，对单列/多列处理，可传入参数
3. applymap，针对cell
4. group
   - 根据多列统计结果
   - 

## Python 可视化

1. [将多张表格绘制到一起并输入到pdf中](https://www.zhihu.com/question/68489126/answer/334893776)

## Python 高级话题

## Python 全栈开发

### Flask

1. [Python爬取疫情实战：Flask搭建web/Echarts可视化大屏/MySQL数据库/Linux项目部署与任务定时调度](https://www.bilibili.com/video/BV177411j7qJ?p=13)
2. Project > flask

   



## 时间处理

1. str->时间

   ```python
   from dateutil.parser import parse
   parse(string) # parse("2019101")
   ```


2. 计算时间差

   ```python
   from datetime import datetime
   (d1-d2).days
   ```

3. [datetime与time库](https://blog.csdn.net/JohinieLi/article/details/83506202)

   - datetime

     > strptime：str -> datetime
     >
     > strftime：datetime -> str

     > datetime的元素
     >
     > date, 获得日期
     >
     > year \ month \ day
     >
     > hour \ minute \ second \ microsecond

   - time

     > 时间戳

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
2. [让你像写SQL一样做数据分析](https://blog.csdn.net/cdk1015/article/details/78744709)
3. [想用Django+ Bootstrap写一个网站， 有哪些比较系统完整的书或者视频可以参考？](https://www.zhihu.com/question/29804463#answer-13798033)
4. [如何发布自己的Python库](https://zhuanlan.zhihu.com/p/66603015)
