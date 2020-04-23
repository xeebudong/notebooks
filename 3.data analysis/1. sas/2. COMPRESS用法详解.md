# SAS COMPRESS用法

 > SAS中，我们一般用COMPRESS来对字符进行压缩，用以删除一些指定的字符，如空格和特殊符号，但C4OMPRESS的功能远不止如此。

## 一．	函数定义

COMPRESS(source <, characters><, modifier(s)>)

- source, 被处理字符串
- character, 指定一栏初始字符，默认它是要从source中移除的
- modifier, 指定一个修饰符，具体功能如下：

| modifier | 含义 |
| ------ | ------ |
|k|不移除初始字符(characters)，而是返回这些字符|
|i|忽略字符大小写|
|a|增加(A-Za-z)、中文到初始字符中|
|l|增加小写字母(a-z)到初始字符中|
|u|增加大写字母(A-Z)到初始字符中|
|d|增加数字到初始字符中|
|c|增加控制字符到初始字符中|
|n|增加数字、下划线和字母(A-Za-z0-9)到初始字符中|
|f|增加下划线和字母(A-Za-z)到初始字符中|
|g|增加图形字符到初始字符中|
|p|增加标点符号到初始字符中|
|s|增加空格(包括空格、水平制表符、垂直制表符、回车符、换行符、换页符)到初始字符中|
|t|删除尾部空格|
|w|增加可印刷的字符到初始字符|
|x|增加十六进制字符到初始字符中|

## 二．	用例

1.	删除空格
  默认情况下，COMPRESS用于删除字符串中所有位置的空格， 此外，还有一些函数用于去除字符串空格，略有不同，如STRIP去除字符串首尾的空格， TRIM删除字符串尾部的空格。
2.	删除指定字符
  COMPRESS，传入2个参数，则删除character中指定的字符。
3.	使用修饰符删除指定字符
  COMPRESS，传入3个参数，则删除character中指定的字符 + modifier中指定的字符（当modifier不为k）。
4.	保留字符
  COMPRESS， 传入3个参数，且modifier为k，则函数功能为保留character中指定的字符(删除除character中指定的字符以外的字符)。

```

DATA test;
	c1 = COMPRESS(“ HELLO,  SAS2019!”); /* 默认删除，字符串中的所有空格*/
	c2 = COMPRESS(“ HELLO,  SAS2019!”, “S!”); /* 指定被删除的字符S以及！*/
	c3 = COMPRESS(“ HELLO,  SAS2019!”, “S!”, “d”); /* 使用修饰符，删除指定的字符S\!以及修饰符指定的数字*/
	c4 = COMPRESS(“ HELLO,   SAS2019!”, “S”, “k”); /* 修饰符使用了k， 表示保留character中的字符(删除除character中指定的字符以外的字符)*/
RUN;
PROC PRINT; RUN;
```