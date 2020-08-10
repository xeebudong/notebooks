# Week1 SAS数据获取及数据探索

> Guideline：快速入手SAS
>
> 学习完本章，将达到以下目标
>
> 1. 按需导入导出数据
> 2. 基本数据清理
> 3. 数据操作
> 4. 数据描述性分析

## 主要内容

1. Hello, SAS

   > 用一个程序，实现SAS的所有元素：数据步、过程步、SQL、宏、数组

2. 数据输入输出

   SAS与数据库连接，另外符文章说明

   SAS默认的数据编码格式是ANSI，有时，SAS输出的数据，需要使用其他编译器取读取，不同编译器默认的编码格式可能有差异，这就造成数据不可读，因此，可以显式定义SAS输出文件的编码格式。

   ```SAS
   FILE EXPORT “xxx.csv” ENCODING = “utf-8”;
   PROC EXPORT DATA=demo
   				OUTFILE – export
   				DBMS = CSV REPLACE;
   RUN;
   ```

   

3. SAS数据集操作

   - 增

   - 删

   - 改(modify、update)

   - 查

   - 数据转置(transpose)

     > UPDATEMODE控制空值是否替代 MISSINGCHECK\NOMISSINGCHECK

     ```SAS
     PROC TRANSPOSE
     	<DATA=input_ds>
     	<DELIMITER=delimiter>
     	<LABEL=label>
     	<LET>
     	<NAME=name>
     	<OUT=output_ds>
     	<PREFIX=prefix>
     	<SUFFIX=suffix>
     	;
     
     	BY var(s); 
     	COPY var(s);
     	ID var;
     	IDLABEL vari;
     	VAR var(s);
     RUN;
     ```

     

     ```SAS
     /* 实例 */
     DATA A3;
         INPUT ID XYZ $ X1 $ X2 $ X3 $;
         CARDS;
     X a1 a2 a3
     Y a4 a5 a6
     Z a7 a8 a9
     X B1 B2 B3
     Y B4 B5 B6
     Z B7 B8 B9
     X C1 C2 C3
     Y C4 C5 C6
     Z C7 C8 C9
         ;
     RUN;
     PROC TRANSPOSE DATA=A3 OUT=B3(DROP=_NAME_);
         VAR X1 X2 X3;
         BY ID;
         ID XYZ;
     RUN;
     PROC PRINT;
     RUN;
     ```

   - 合并：merge(坑，尤其是多对多和多对一)、set

     - Merge、modify、update的区别

4. SAS数据探索

   - 空值检验：行/列

   - 异常值检验

   - 数据探索

     > PROC UNIVARIATE, 深入解析SAS P331

     - 字符型-频数分析
     - 数字型-描述性分析
       - 集中程度：MEAN、MEDIAN、MODE
       - 离散程度：STD、VAR、CV(变异系数)=std/mean、RANGE(极差)、Q1-Q4
       - 数据分布：偏度(左偏、右偏)、峰度、百分位数、直方图

     ```SAS
     PROC MEANS DATA=<option>;
     	CLASS <vars list>;
     	VAR <vars list>;
     	BY <vars list>;
     	FREQ <vars list>;
     	WEIGHT <vars list>;
     	ID <vars list>;
     	OUTPUT OUT=outfile;
     RUN;
     ```

   

## SAS编码

> 使用不同的开发语言，对一个项目进行交替作业，编解码真是一个令人头疼的问题。笔者使用了Python和SAS进行SNA社交网络分析项目的开发。Python使用pd.read_sas读取sas数据集，默认读入bytes，如0xCC等，这类字符对阅读是不友好的，如果要得到人类可读的字符串，要进行decode。

1. 中文字符的显示与存储

   > 一般，遇到解码问题，大部分都是中文，所以，这里以中文来解释，其基本流程是： 屏幕上显示的中文字符 -> encode(gbk，utf-8等方式) -> 存储到介质中 -> decode(gbk、utf-8等方式) -> 显示到屏幕上， encode和decode使用的方式要是一致才可以


2. SAS的中文字符编解码
   - 默认的编码、解码方式
   - 是否可以更改编码解码方式

3. 字符集&字符编码
4. 实例

```SAS
/*生成数据*/
option encoding = "utf-8";
DATA ch;
	ch = "我是中国人";
	en = "I am English";
	ch2 = "屌";
RUN;

FILENAME export "D:\ch.csv" ENCODING="gbk";
PROC EXPORT DATA = ch
			  OUTFILE = export
			  DBMS = CSV REPLACE;
RUN;
```

```python
# -*- coding: utf-8 -*-
"""
Created on Wed Oct 17 14:46:17 2018

@author: TEST

Python读入数据
"""

import pandas as pd

df = pd.read_sas(r"D:\ch.sas7bdat", encoding="utf-8")
df2 = pd.read_csv(r"D:\ch.csv")
```

5. 参考
   - [十分钟搞清字符集和字符编码](https://yq.aliyun.com/articles/86805)
   - [SAS导入导出时编码问题汇总](http://alitrack.com/2016/11/17/sas%E5%AF%BC%E5%85%A5%E5%AF%BC%E5%87%BA%E6%97%B6%E7%BC%96%E7%A0%81%E9%97%AE%E9%A2%98%E6%B1%87%E6%80%BB/)

## Class和by的区别

- 输出样式不同：by按分类输出到不同报表；class按分类输出到相同一张报表
- 输入要求不同：by要排序；class不需要
- 空值处理不同：class自动将空值排除在统计结果以外，by将缺失处理为一类
  使用class时，在OPTION中指定MISSING，系统会认为缺失也为一类

## SAS数据集合并-update、merge、modify的区别与特性

1. 原理

   > update\merge\modify\set操作数据流，参考《深入解析SAS》

2. 性能

3. 比较

4. 应用

5. 参考

   - [SET MERGE UPDATE MODIFY语句对比](http://blog.sina.com.cn/s/blog_6c1c13fc0100lyi7.html)
   - [sas数据操作update、modify by ke=、控制modify的更新、datasets添加约束条件、操作文件变动aduit trail](https://www.cnblogs.com/yican/p/3799883.html)
   - [SAS进阶《深入解析SAS》之对多数据集的处理](https://blog.csdn.net/dream_an/article/details/50455511)
   - [sas中modify比merge、update效率高嘛？](http://bbs.pinggu.org/thread-2145851-1-1.html)

## Merge陷阱

> 单独将MERGE单独拿出来，是因为SAS的MERGE在使用的时候，容易陷入经验的误区，掉坑

- 数据关联

  一般而言，数据关联包括：自然连接、内连接、外连接(全连接、左连接、右连接)

  - 自然连接 在两个表的相同属性组上进行笛卡尔积关联，并且在结果中把重复的属性列去掉，在关联时，不显式的指定属性列
  - 内连接	组合两个表中的记录，返回关联字段相符的记录，也就是返回两个表的交集（阴影）部分
  - 外连接
    - 左连接，左表(a_table)的记录将会全部表示出来，而右表(b_table)只会显示符合搜索条件的记录。右表记录不足的地方均为NULL
    - 右连接，与左(外)连接相反，右(外)连接，左表(a_table)只会显示符合搜索条件的记录，而右表(b_table)的记录将会全部表示出来。左表记录不足的地方均为NULL
    - 全连接，显示左表和右表的并集，左表或右表记录不足的地方均为NULL

- SAS中的Merge语法

  > 这里，先概述SAS中MERGE的语法，然后指出和常识认识的差异。我们以两张表来距离， A MERGE B ON cols
  >
  > 接触一门新语言的时候，还是要认真看关键字的使用说明，不然，很容易掉入语言设计缺陷的坑里

  - A和B均在cols上唯一, 不存在歧义
  - A在cols上不唯一， B在cols上唯一
  - A在cols上唯一，B在cols上不唯一
  - A、B在cols上均不唯一，这就是所谓的多对多的MERGE

- 参考文献

  - [图解MySQL 内连接、外连接、左连接、右连接、全连接](https://blog.csdn.net/plg17/article/details/78758593)
  - [数据合并MERGE全攻略](http://bbs.pinggu.org/thread-4647057-1-1.html)

  

# Week2 SAS编程规范与设置

> 第一章，相当于一个quickstart，掌握第一章的内容，基本上就可以使用SAS编程，实现一些数据分析的功能。
> 本章，先不对SAS的具体语法进行讲解，而是对SAS编程规范以及SAS中一些关键字进行说明。这将对未来的开发带来一些便利。

1. 日志持久化

   ```SAS
   PROC PRINTTO LOG=”log.dat” NEW; /* 指定日志输出文件 */
   ODS LISTING FILE=”file.txt”; /* 指定结果输出文件 */
   ```

2. ODS

   ```SAS
   /*ODS RESULTS OFF ;*/
   /*ODS LISTING CLOSE;*/
   /*ODS EXCEL FILE="C:\01_Projects\05_数据准备\02_数据处理阶段检查（部分数据有更新）\...\....xls"*/
   /* OPTIONS(SHEET_INTERVAL='NONE' SHEET_NAME="..." embedded_titles='yes');*/
   /*%missrate(rawd,LN_APP_CONT_INC);*/
   /*ODS EXCEL OPTIONS(SHEET_INTERVAL='NONE' SHEET_NAME="LN_INDV_CUST_INFO_ZJG");*/
   /*%missrate(rawd,LN_INDV_CUST_INFO_INC);*/
   /*ODS EXCEL CLOSE;*/
   /*ODS RESULTS ON;*/
   /*ODS LISTING;*/
   ```

   

3. 关键字

   - OBS 
   - FIRSTOBS 
   - POINT 
   - RETAIN
   - FIRST
   - LAST

```SAS
* 实现前向填充， 如下：
DATA tb;
	SET ta;
	BY a;
 	RETAIN m;

	IF FIRST.a THEN m=b;
	IF NOT MISSING(b) THEN m=b;
	ELSE DO;
	   B=m;
	   M=b;
	 END;
RUN;
```


4. 双划符--， 按顺序取数据

   ```SAS
   Data temp1;
    Input x y z u v w,
   Cards;
   1 2 3 4 5 6
   7 8 9 10 11 12
   ;
   Run;
   
   Data temp2;
   	Set temp1;
   	Keep
   		x--u
   	;
   Run;
   ```

6.	批量删除Label

```SAS
/*Drop the label of sashelp.class*/
PROC DATASETS LIB=SASHELP NOLIST;
		MODIFY class;
		ATTRIB _ALL_ LABEL=””;
RUN;
```



# Week3 基本语法

1. 数据类型

   - 获取变量类型 vtype vtype=”N”, 为数字型； vtype=”C”, 为字符型
   - 数据类型转换， ① PUT\INPUT， ② 直接转换

2. 逻辑判断

3. 数值计算
   将小数点显示为百分数，PUT(val, PERCENT8.2); /* 使用PUT */

4. 数组

   > SAS和数据打交道，对于数据，我们就要知道数据类型，在数据上面怎么进行计算以及逻辑判断。此外，数据集合涉及到数组的操作。以上，是构成SAS数据分析的主要语法。

## OUTPUT之后，再STOP

```SAS
data a; /*建立数据集a*/ 
	do obsnum=1 to last by 20; /*使用循环语句，循环变量obsnum从1变到last， 步长为20，last值为stk000001的总的记录数,目的是在stk000001中每隔20条 记录提取一条记录到a中*/ 
		set sashelp.aacomp point=obsnum nobs=last; /*使用set语句读入数据集resdat.stk000001，利用point选项定位数据指针，利用nobs选项获取数据集总的记录数*/ 
		output; /*输出当前记录*/ 
	end; /*结束循环*/ 
	stop; /*停止data步,在该程序中不可以删除，否则 
因为point选项的缘故，程序无法读取文件结束标示，会陷入死循环*/ 
run; /*提交程序*/

data x;
	k = 21;
	set sashelp.aacomp point = k;
	output;
	stop;
run;
```



# Week SAS函数

> 主要讲解时间函数、字符串函数、数值运算函数，并对时间输入输出格式进行讲解。 参考 the little book & 清华大学教材



# Week4 宏-MACRO

> [宏语言基础](https://wenku.baidu.com/view/9a7ed897e45c3b3567ec8beb.html)

1. 宏的类型

   > [SAS定义宏变量的三种方法](http://blog.sina.com.cn/s/blog_7f8b10ef01013m1e.html)

   - %LET定义
     - %STR， 当宏变量是一个表达式时使用，例如%LET print = %STR(PROC PRINT; RUN;);
     - %EVAL_R，用于计算整数，例如 %EVAL_R(1+2)
     - %SYSEVALF, 用于计算浮点数或者为空， 例如%SYSEVALF(1.0+2.3)
   - CALL SYMPUT
   - SELECT INTO:

2. 宏的可视化范围

3. let vs call symput vs select into:

   - %let xxx=yyy; 
   - call symput('xxx','yyy');
   - select xxx into: yyy.

   三种定义方式最大的区别是在MACRO函数内定义所生成的宏变量的类型不同：

   - CALL SYMPUT在宏函数中定义的宏变量可以在函数外调用；

   - %LET和 SELECT INTO:不能在函数外调用，因为这2种方法在MACRO函数内生成的是局部宏变量，若要想在MACRO函数外调用，需事先用%global申明变量类型。

     ```SAS
     %macro test();
     
     data _NULL_;
     	call symput('Today',put(today(),date9.));
     run;
     
     * Method 2
     %let today=%sysfunc(today(),date9.);
     
     * Method 3
     data todaydate;
     date=today();
     Proc sql noprint;
     select put(date,date9.) INTO: today
     from todaydate
     ;
     quit;
     %put &today;
     %mend;
     %test;
     
     %put &today;
     ```

     

4. 函数

   > SAS9.6开始，也支持自定义函数功能，这对于程序员来说，是一件好事

```SAS
OPTIONS CMPLIB=WORK.FUNCS;
PROC FCMP OUTLIB=WORK.FUNCS.CHI;
		FUNCTION GETMAX(a, b);
 			IF a>= b THEN RETURN(a);
 			ELSE RETURN(b);
 		ENDSUB;
RUN;

DATA demo;
	Y = GETMAX(2, 7);
RUN;
PROC PRINT; RUN;
```

## SAS中，如何实现不定参数

> 在写宏或者函数时，为了实现函数/宏的复用，我们往往将函数/宏写的通用。在做评分卡模型评估时，我们需要做的是对模型稳定性和变量进行评估，所以评分卡打完分之后，我们只需要输出样本id、score、时间戳以及入模变量即可。每一张评分卡的入模变量都不尽相同，我们可以在评分卡代码中，使用KEEP语句输出，如下，宏里面定义了4个入参。这存在以下几个问题:

  - 不同的评分卡要去手动修改KEEP中的内容
  - 另一种解决方案是，在入参中加入待Keep的变量，但变量的数量不一定；这时候，就需要不定参数。SAS的解决方案是使用PARMBUFF
  - 参考：[sas 参数个数不定的宏](https://bbs.pinggu.org/thread-1307350-1-1.html)

```SAS
  %MACRO SCORECARD(lib_in, ds_in, lib_out, ds_out);
      DATA &lib_out..&ds_out.;
          SET &lib_in..&ds_in.;
          ...
          KEEP
            idnumber
            score
            dt
            var1
            var2
            ...
            varn
          ;
      RUN;
  %MEND;
```



# Week5 SAS SQL

> SQL VS MERGE， 效率



# Week6 时间运算

> 坦白讲，时间运算也是我头疼的地方，尤其是涉及到SAS和其他产品的数据对接，如MySQL、Python。下面，就重要对时间以及基于时间的运算进行讲解

1.	根据月份，获得当月最早一天(最晚一天)
dt_fst = INPUT(PUT(INTNX(“MONTH”, INPUT(PUT(&mth., Z6.), YYMMN6.), 0, “BEGIN”), YYMMDDN8.), 8.)
2.	获取当日所在月份的最早一天
dt_fst = INPUT(PUT(INTNX(“MONTH”, TODAY(), 0, “BEGIN”), YYMMDDN8.), 8.)
3.	根据当前月份，获得下一个月
Call symput(“mth”, PUT(INTNX(“MONTH”, INPUT(PUT(201511, Z6.), YYMMN6.), 1), YYMMN6.));



# Week7 SAS开发闭环

> SAS是一个处理数据的工具。从不同的数据文件抽取数据，处理数据，再输出数据、甚至形成报表。我们在第一章就讲了输入输出，将处理结果存储为文件，是一种方式，但不便于数据的共享和流动。
> 在生产中，作为一个开发闭环，往往需要将结果数据存放到数据库中，数据的使用者再从数据库中读取数据。本章以Mysql为例，将SAS如何实现与数据库的交互；此外，对SAS报表做一些介绍。

1. PROC SQL;
   CONNECT TO ODBC AS imp(DATASRC=”username”);
   CREATE TABLE tbl_name
   AS
   SELECT 1 FROM CONNECTION TO imp( /*SELECT 1 FROM …为固定写法*/
   		/*Write sql here， 增删改查、建表*/
   		SELECT * FROM mysql_tbl_name
   );
   DISCONNECT FROM xieb;
   QUIT;
2. 从数据库读入数据
   LIBNAME DT ODBC DATASRC = “db_name”;
   注意，要先配置好ODBC
3. 将数据写到数据库
   PROC APPEND BASE=db_remote DATA=db_local FORCE; RUN;
4. 和一类似
   EXECUTE(DBMS SQL) BY db_name
5. SAS连接数据库

# Week8 SAS报表

1. SAS绘图

[如何用SAS画统计图](https://bbs.pinggu.org/thread-6102023-1-1.html)

[[用了SAS八年，这是最实用的画图程序，SAS作图程序](https://bbs.pinggu.org/thread-3547938-1-1.html)

[SAS作图是不真的又难又丑啊? 其实是你不知道](http://www.medsci.cn/article/show_article.asp?id=641a6312484)

# Week SAS优化

## [索引](https://blog.csdn.net/jjxgmao/article/details/51926567)

> 是对数据集观测进行操作的强有力工具
>
> 可以帮助你快速定位一条或多条想要读取的符合特定条件的观测
>
> 在没有索引的情况下，SAS是一条接一条的扫描观测；有索引时，直接跳到该索引对应的观测所在位置，总结一句话：节省时间、节省内存、提高效率



# 参考

1. [SAS Studio](https://odamid.oda.sas.com/SASStudio/)
2. 