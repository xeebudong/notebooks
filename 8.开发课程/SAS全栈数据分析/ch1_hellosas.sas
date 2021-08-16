/* 数据步 */
DATA class;
	SET sashelp.class; /* 数据获取：使用SET语句，获取SAS文件数据 */
RUN;

/* 过程步 */
PROC SORT DATA = class; BY age; RUN; /* 排序：对class数据排序(以age升序) */

/* 过程步 */
PROC FREQ DATA = class; TABLES sex; RUN; /* 频数分析：按性别统计数量 */

/* 
	SAS SQL 
	使用SAL实现频数分析
*/
PROC SQL;
	CREATE TABLE stat_sex
	AS
	SELECT
		sex
		, COUNT(*) AS cnt
	FROM
		class
	GROUP BY
		sex
	; 
QUIT;

/*
	利用过程步实现频数分析
*/
PROC FREQ DATA = class; TABLES sex; RUN; 



/* 过程步 */
PROC CONTENTS DATA = class OUT = class_contents;
RUN;




/*-------------------------------------------------------------
数据输入输出
--------------------------------------------------------------*/

PROC IMPORT 
			DATAFILE = "G:\文章\SAS全栈数据分析\ch1_demo.xlsx"
			OUT = student
			DBMS = EXCEL REPLACE
			;
			
			SHEET = "sheet1";
			GETNAMES = YES;
RUN;


PROC IMPORT 
			DATAFILE = "G:\文章\SAS全栈数据分析\ch1_demo.csv"
			OUT = student
			DBMS = CSV REPLACE
			;
			GUESSINGROWS  = 20;
			GETNAMES = YES;
RUN;




/**********************************************************************
*   PRODUCT:   SAS
*   VERSION:   9.2
*   CREATOR:   External File Interface
*   DATE:      17MAR18
*   DESC:      Generated SAS Datastep Code
*   TEMPLATE SOURCE:  (None Specified.)
***********************************************************************/

DATA WORK.STUDENT                                 ;
	%LET _EFIERR_ = 0; /* set the ERROR detection macro variable */
    INFILE 'G:\文章\SAS全栈数据分析\ch1_demo.csv' DELIMITER = ',' MISSOVER DSD LRECL=32767 FIRSTOBS=2 ;
    INFORMAT name $9950. ;
    INFORMAT age best32. ;
    INFORMAT gender $7. ;
    FORMAT name $9950. ;
    FORMAT age best12. ;
    FORMAT gender $7. ;

	INPUT
    	name $
        age
        gender $
    ;
    IF _ERROR_ THEN CALL symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
RUN;


PROC EXPORT DATA = SASHELP.class
			 OUTFILE = "G:\文章\SAS全栈数据分析\ch1_dataoutput.csv"
			 DBMS = CSV LABEL REPLACE
	;
	DELIMITER = "&";
RUN;


/*------------------------------------------------------
OUTOUT
------------------------------------------------------*/

DATA class;
	SET SASHELP.class;

	IF age = 11 THEN OUTPUT;
	IF sex = "女" THEN OUTPUT;
RUN;

DATA ds_combine;
	SET SASHELP.class SASHELP.air;
RUN;

PROC APPEND BASE = class DATA = SASHELP.class FORCE; RUN;


DATA ds_A;
	INPUT id 2 NAME $5. age 2;
	CARDS;
01 luli 21
08 john 29
05 tom  31
	;
RUN;

DATA ds_B;
	INPUT id 2 NAME $5. age 2 gender $1.;
	CARDS;
02 Jak  28 1
10 cat  21 2
04 lili 32 2
	;
RUN;

PROC SORT DATA = ds_A; BY id; RUN;
PROC SORT DATA = ds_B; BY id; RUN;

DATA ds_combine;
	SET ds_A ds_B;
	BY id;
RUN;


DATA ds_merge;
	MERGE
		ds_A(IN = A)
		ds_B(IN = B)
	;
	BY id;
	IF A OR B;
RUN;
