# 切割字符串 http://justdo2008.iteye.com/blog/1141609

# 1. substring_index(str,delim,count)
# 截取第二个 '.' 之前的所有字符。
select substring_index('www.sqlstudy.com.cn', '.', 2);
+------------------------------------------------+
| substring_index('www.sqlstudy.com.cn', '.', 2) |
+------------------------------------------------+
| www.sqlstudy                                   |
+------------------------------------------------+
# 2 截取第二个 '.' （倒数）之后的所有字符。
mysql> select substring_index('www.sqlstudy.com.cn', '.', -2);
+-------------------------------------------------+
| substring_index('www.sqlstudy.com.cn', '.', -2) |
+-------------------------------------------------+
| com.cn                                          |
+-------------------------------------------------+
# 3 如果在字符串中找不到 delim 参数指定的值，就返回整个字符串
mysql> select substring_index('www.sqlstudy.com.cn', '.coc', 1);
+---------------------------------------------------+
| substring_index('www.sqlstudy.com.cn', '.coc', 1) |
+---------------------------------------------------+
| www.sqlstudy.com.cn                               |
+---------------------------------------------------+