*------------------------------------------------------------*;
* 数据源设置;
*------------------------------------------------------------*;
libname EMWS1 "D:\git\notebooks\5. data analysis\1. sas\sas em\CaseStudy\My Project\Workspaces\EMWS1";
*------------------------------------------------------------*;
* Ids: 正在创建“DATA”数据;
*------------------------------------------------------------*;
data EMWS1.Ids_DATA (label="")
/ view=EMWS1.Ids_DATA
;
set SAMPSIO.HMEQ;
run;
