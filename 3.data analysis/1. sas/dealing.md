



output 之后，在stop


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




sas expoer csv encoding
http://alitrack.com/2016/11/17/sas%E5%AF%BC%E5%85%A5%E5%AF%BC%E5%87%BA%E6%97%B6%E7%BC%96%E7%A0%81%E9%97%AE%E9%A2%98%E6%B1%87%E6%80%BB/

