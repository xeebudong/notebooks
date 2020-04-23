一.	SAS数据获取及数据探索
Guideline：
0. Hello， SAS
	用一个程序，实现SAS的所有元素：数据步、过程步、SQL、宏、数组
1.	数据输入输出
SAS与数据库连接，另外符文章说明

SAS默认的数据编码格式是ANSI，有时，SAS输出的数据，需要使用其他编译器取读取，不同编译器默认的编码格式可能有差异，这就造成数据不可读，因此，可以显式定义SAS输出文件的编码格式。
FILE EXPORT “xxx.csv” ENCODING = “utf-8”;
PROC EXPORT DATA=demo
				OUTFILE – export
				DBMS = CSV REPLACE;
RUN;

2.	Sas数据集操作
增、删、改(modify、update)、查、数据转置(transpose)
	UPDATEMODE控制空值是否替代
	MISSINGCHECK\NOMISSINGCHECK
合并：merge(坑，尤其是多对多和多对一)、set
Merge、modify、update的区别
3.	空值检验(行、列)
4.	异常值检验
5.	Sas数据探索
学完本章节，将实现以下目标：
1. 按需导入导出数据
2. 基本数据清理
3. 数据操作
4. 数据描述性分析
PROC UNIVARIATE, 深入解析SAS P331
集中程度：MEAN、MEDIAN、MODE
离散程度：STD、VAR、CV(变异系数)=std/mean、RANGE(极差)、Q1-Q4
数据分布：偏度(左偏、右偏)、峰度、百分位数、直方图

PROC MEANS DATA=<option>;
	CLASS <vars list>;
	VAR <vars list>;
	BY <vars list>;
	FREQ <vars list>;
	WEIGHT <vars list>;
	ID <vars list>;
	OUTPUT OUT=outfile;
RUN;

Class和by的区别
1.	输出样式不同：by按分类输出到不同报表；class按分类输出到相同一张报表
2.	输入要求不同：by要排序；class不需要
3.	空值处理不同：class自动将空值排除在统计结果以外，by将缺失处理为一类
使用class时，在OPTION中指定MISSING，系统会认为缺失也为一类



二.	SAS编程规范与设置
第一章，相当于一个quickstart，掌握第一章的内容，基本上就可以使用SAS编程，实现一些数据分析的功能。
本章，先不对SAS的具体语法进行讲解，而是对SAS编程规范以及SAS中一些关键字进行说明。这将对未来的开发带来一些便利。
1.	日志持久化
PROC PRINTTO LOG=”log.dat” NEW; /* 指定日志输出文件 */
ODS LISTING FILE=”file.txt”; /* 指定结果输出文件 */
2.	ODS
3.	关键字
OBS FIRSTOBS POINT RETAIN

前向填充， 如下：
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
4.	双划符--， 按顺序取数据
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

5.	FIRST LAST OBS
6.	批量删除Label

/*Drop the label of sashelp.class*/
PROC DATASETS LIB=SASHELP NOLIST;
		MODIFY class;
		ATTRIB _ALL_ LABEL=””;
RUN;
7.	

三.	基本语法
数据类型
	获取变量类型 vtype vtype=”N”, 为数字型； vtype=”C”, 为字符型
	数据类型转换， ① PUT\INPUT， ② 直接转换
逻辑判断
数值计算
将小树显示为百分数，PUT(val, PERCENT8.2); /* 使用PUT */
数组
SAS和数据打交道，对于数据，我们就要知道数据类型，在数据上面怎么进行计算以及逻辑判断。此外，数据集合涉及到数组的操作。以上，是构成SAS数据分析的主要语法。

四.	宏-MACRO
宏的类型
宏的可视化范围


SAS9.6开始，也支持自定义函数功能，这对于程序员来说，是一件好事。
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

五.	SAS SQL
SQL VS MERGE， 效率

六.	时间运算
坦白讲，时间运算也是我头疼的地方，尤其是涉及到SAS和其他产品的数据对接，如MySQL、Python。下面，就重要对时间以及基于时间的运算进行讲解

1.	根据月份，获得当月最早一天(最晚一天)
dt_fst = INPUT(PUT(INTNX(“MONTH”, INPUT(PUT(&mth., Z6.), YYMMN6.), 0, “BEGIN”), YYMMDDN8.), 8.)
2.	获取当日所在月份的最早一天
dt_fst = INPUT(PUT(INTNX(“MONTH”, TODAY(), 0, “BEGIN”), YYMMDDN8.), 8.)
3.	根据当前月份，获得下一个月
Call symput(“mth”, PUT(INTNX(“MONTH”, INPUT(PUT(201511, Z6.), YYMMN6.), 1), YYMMN6.));
4.	

七.	SAS开发闭环
SAS是一个处理数据的工具。从不同的数据文件抽取数据，处理数据，再输出数据、甚至形成报表。我们在第一章就讲了输入输出，将处理结果存储为文件，是一种方式，但不便于数据的共享和流动。
在生产中，作为一个开发闭环，往往需要将结果数据存放到数据库中，数据的使用者再从数据库中读取数据。本章以Mysql为例，将SAS如何实现与数据库的交互；此外，对SAS报表做一些介绍。
一. 
PROC SQL;
CONNECT TO ODBC AS imp(DATASRC=”username”);
CREATE TABLE tbl_name
AS
SELECT 1 FROM CONNECTION TO imp( /*SELECT 1 FROM …为固定写法*/
		/*Write sql here， 增删改查、建表*/
		SELECT * FROM mysql_tbl_name
);
DISCONNECT FROM xieb;
QUIT;

二. 从数据库读入数据
LIBNAME DT ODBC DATASRC = “db_name”;
注意，要先配置好ODBC

三．将数据写到数据库
PROC APPEND BASE=db_remote DATA=db_local FORCE; RUN;

四. 和一类似
EXECUTE(DBMS SQL) BY db_name

SAS连接数据库
SAS报表

# SAS绘图
https://wenku.baidu.com/view/cc8d1f7d866fb84ae55c8d66.html

https://bbs.pinggu.org/thread-6102023-1-1.html

https://bbs.pinggu.org/thread-3547938-1-1.html

http://www.medsci.cn/article/show_article.asp?id=641a6312484



1. [SAS字符串处理](http://www.jintiankansha.me/t/vh7Vgk3IPc)



SAS数据处理，转置
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



# ODS 参考
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