利用Django搭建词云网站(深圳和君)
# 功能模块设计

> 根据和君同学提交的资料，进行了数据统计，并针对同学们的兴趣爱好、从事工作做了简单的相似性推荐。希望对同学们在和君找到更加志同道合的同学、朋友能有帮助(也别忘了长尾理论，多和不一样的角色交流，对丰富我们的人生阅历很有好处哦！)。由于数据量小，构不成大数据统计，纯属是出于数据工程师对数据分析的热爱，做的一点小统计，也是作为对Python全栈的一次实践。本项目搭建在OpenShift上，采用Django框架，前端用Semantic + Highchart， 数据库采用Mongodb。

## Summary

1. 按照性别、学校、学历、专业(分大类)、行业(分大类)进行分类
	
	- 性别：男、女
	- 学校：海内(C9\982\211\其他)、海外或者按照学校名称分
	- 学历：本、硕、博、其他
	- 年龄
	- 专业：经管、工科、文科、理科
	- 行业：金融、互联网、法律、会计、其他
2. 提供性别和其他类别的联合查询

## 个人标签(词云)

1. 默认为所有信息构成的总体词云，词云样式为和君或者和君的Log
2. 在搜索框内输入自己的名字，可以查看自己的词云，是男性就按照男性的样式显示，女性按照女性样式显示

## 与君同行
> 找出与自己相似的人，对各个维度赋不同的权重

1. 默认为根据综合相似查找
2. 在下拉框中可以选择按行业、爱好、学历背景等分(学历背景主要考量是否是同一个学校-分类和上面相同、是否是同类别学校、是否专业相近)
3. 样本相似度的计算(选择了某种方式，如爱好，爱好的权重赋值最高，并不意味着其他权重为0，还是要参考行业、学历等信息)
4. 对推荐用户进行解释(因为你们爱好相似)

## 技术点

1. 在OpenShift上搭建Django开发环境
2. 分词(jieba\NLTK)
3. Mongodb
4. 词云(wordCloud)
5. highchart(在Django中的使用)
6. Semantic(UI)

## 逐个击破
### 分词

- 姓名
- 籍贯
- 性别
- 学校
- 学历
- 专业
- 爱好
- 公司
- 工作领域
- 个人标签(根据词云生成)

### 
1. 对中文名字进行性别分类
2. 提取学校
3. 爱好(如何从文本中提取用户爱好)

# 参考文献

1. [Python NLTK学习7（对中文昵称进行性别分类）](http://dataunion.org/26979.html)
2. [NLTP入门-判别性别](http://blog.ourren.com/2014/12/26/nlp_with_sex_for_beginners/)
3. [Python词云-WordCloud](http://www.voidcn.com/blog/tanzuozhev/article/p-5048568.html)
4. [用Python进行自然语言处理]()
5. [在 NLTK 中使用 Stanford NLP 工具包](http://www.zmonster.me/2016/06/08/use-stanford-nlp-package-in-nltk.html)

# 拓展阅读

1. [基于大数据的中文舆情分析](https://www.ibm.com/developerworks/cn/data/library/bd-1404optionanalysis/index.html)
2. [基于Spark的文本情感分析](https://www.ibm.com/developerworks/cn/cognitive/library/cc-1606-spark-seniment-analysis/index.html)