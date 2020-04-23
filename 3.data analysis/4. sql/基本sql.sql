# 查询库中所有表名，及表的大小


# 查询表数据字典
SHOW COLUMNS FROM dw_datas_connection


# 查询建表语句

# 数据备份
> mysqldump -u dbmgr -p --all-databases > D:\backup\hx_db.sql


# 创建用户
create user guest@"%" identified by "guest";

# 创建访问数据库权限 all privileges
grant select,insert,update,delete on ods_huaxia_datas.* to guest@"%" identified by "guest";
grant select,insert,update,delete on ods_huaxia_biz.* to guest@"%" identified by "guest";
grant select,insert,update,delete on dw_huaxia_datas.* to guest@"%" identified by "guest";
grant select,insert,update,delete on dw_huaxia_biz.* to guest@"%" identified by "guest";
grant select on user.* to guest@"%" identified by "guest";


# 
grant all privileges on *.* to guest@"%" identified by "guest";
flush privileges ;





# 设置用户操作权限【服务器权限】
grant select,insert,update,delete on *.* to guest@"%" identified by "guest" ;


# 设置用户远程访问权限
grant all privileges on *.* to guest@"%" identified by "guest"
