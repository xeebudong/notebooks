*------------------------------------------------------------*;
* ����Դ����;
*------------------------------------------------------------*;
libname EMWS1 "D:\git\notebooks\5. data analysis\1. sas\sas em\CaseStudy\demo_scorecard\Workspaces\EMWS1";
*------------------------------------------------------------*;
* Ids: ���ڴ�����DATA������;
*------------------------------------------------------------*;
data EMWS1.Ids_DATA (label="")
/ view=EMWS1.Ids_DATA
;
set SAMPSIO.CS_ACCEPTS;
run;
