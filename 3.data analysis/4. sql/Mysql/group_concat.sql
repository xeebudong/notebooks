#Reference:http://javeye.iteye.com/blog/558093

# data sample 
#uit	bpid	district	data	fining_id	fpname	fsubname	fgsubname	earn_coins
#4119120	昆明	2016-10-30	293910	斗牛	LV12		-9900

select dt, fining_id, fpname, GROUP_CONCAT(district, earn_coins) as gameparty_detail from km_gameparty_d1
GROUP BY dt, fining_id, fpname;