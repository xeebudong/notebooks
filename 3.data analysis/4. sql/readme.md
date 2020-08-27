## 基本操作

1. 查询库中所有表名，及表的大小

2. 查询表数据字典

`SHOW COLUMNS FROM dw_datas_connection`

3. 查询建表语句
4. 数据备份

`mysqldump -u dbmgr -p --all-databases > D:\backup\hx_db.sql`

5. 创建用户

`create user guest@"%" identified by "guest";`

6. 创建访问数据库权限 all privileges

```mysql
grant select,insert,update,delete on ods_huaxia_datas.* to guest@"%" identified by "guest";
grant select,insert,update,delete on ods_huaxia_biz.* to guest@"%" identified by "guest";
grant select,insert,update,delete on dw_huaxia_datas.* to guest@"%" identified by "guest";
grant select,insert,update,delete on dw_huaxia_biz.* to guest@"%" identified by "guest";
grant select on user.* to guest@"%" identified by "guest";
# 
grant all privileges on *.* to guest@"%" identified by "guest";
flush privileges ;
```

7. 设置用户操作权限【服务器权限】

`grant select,insert,update,delete on *.* to guest@"%" identified by "guest" ;`

8. 设置用户远程访问权限

`grant all privileges on *.* to guest@"%" identified by "guest"`

## Mysql常用功能

### 增

### 删

### 改

### 查

1. 查找表中idx以100结尾

   `select * from tabelname where idx regexp '100$';`

2. 查找表中idx不以100结尾
   `select * from tabelname where idx not regexp '100$';`

### 字符串操作

> 切割字符串 http://justdo2008.iteye.com/blog/1141609

1. substring_index(str,delim,count)

   > 截取第二个 '.' 之前的所有字符。

   `select substring_index('www.sqlstudy.com.cn', '.', 2);`

2. 截取第二个 '.' （倒数）之后的所有字符

   `mysql> select substring_index('www.sqlstudy.com.cn', '.', -2);`

3. 如果在字符串中找不到 delim 参数指定的值，就返回整个字符串

   `select substring_index('www.sqlstudy.com.cn', '.coc', 1);`

4. 分组合并字符

   > http://javeye.iteye.com/blog/558093

   `select dt, fining_id, fpname, GROUP_CONCAT(district, earn_coins) as gameparty_detail from km_gameparty_d1
   GROUP BY dt, fining_id, fpname;`

## MySQL语法

> [MySQL快速入门-函数编程](http://blog.csdn.net/qianqin_2014/article/details/52156819)

### 变量

!image[结构图](http://img.blog.csdn.net/20160808234432791)

### 定义语法

set @var = value

## Mysql调优

> 参考文献

1. [MySQL索引原理及慢查询优化](http://tech.meituan.com/mysql-index.html)
2. [mysql中的存储过程和自定义函数](http://www.jianshu.com/p/0ff862270838)



