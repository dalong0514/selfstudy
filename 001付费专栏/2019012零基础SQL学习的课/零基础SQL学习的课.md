# 零基础 SQL 学习的课堂
> Lyon 12-30 19:26

不知道大家平时有没有做分析，需要去找研发要数据的情况。一来占用团队的开发资源，二来如果有新的问题又得再麻烦一次。甚至光描述清楚你想要怎样的数据都是一件比较麻烦的事。但其实大部分信息都在数据库里，完全可以自己动手查询。而且这事儿其实一点也不复杂。

不过想要查询公司的数据库，需要向技术负责人申请数据库的访问权限，一般从库的查询权限就可以了「从库就是一个实时同步的备份数据库，避免影响线上业务」，同时别忘了问清楚数据库有哪些表，表中都有怎样的字段。

然后通过客户端或者网页管理界面，登录数据库，初次访问最好请研发的同学示范一下。

我们将以 phpMyAdmin 的操作界面为例，通过一个示例数据库，来讲讲怎样通过 SQL 来查询数据。

## SQL 上手

不过在此之前，我们先介绍一下什么是数据库和数据表。

数据表就是存放用户信息的表格文件，其实和大家熟悉 Excel 文件是一样的：

表头定义了一张数据表包含哪几列：姓名、年龄、分数等等，每一列我们称之为一个字段。

之后的数据都按照表头定义的格式逐行记录。

如果将上面 Excel 表格中的数据另存为 csv 格式，并用记事本打开，可以看到这样的内容：

Name,Age,Score

张三,18,99

李四,17,97

不过 Excel 可能 10 万条数据就卡的不行了，但一张数据表可以放置几百万甚至几十亿条记录，还能在几十毫秒内处理完我们的查询请求。

而数据库就是一张张这样的表格的集合，大家可以将数据库理解成一个文件夹，里面的文件就是数据表。

这样以表格的形式存储信息的数据库，我们称为关系型数据库，比如大家可能听过的 MySQL，Oracle，就是典型的关系型数据库系统。

MySQL 是目前使用最广的数据库产品，其他常见数据库还包括 oracle，和 SQL Server。

关系型数据库是绝大多数互联网应用的基础，我们的用户信息，交易记录，大都存储在关系型数据库中。

下面请大家访问 phpMyAdmin 的官方演示服务器 https://demo.phpmyadmin.net/ 点击右侧【Try Demo】按钮，即可进入操作界面，如下图。

由于是公共的演示服务器，可能会有一些干扰，打开也比较慢，如果出现访问异常，可以等待数据库自动恢复。

界面左侧，像目录一样部分，就是当前演示服务器中的数据库列表，我们找到即将使用的 world 数据库。点击左边的 + 号，可以展开看到这个数据库包含了三张表 City, Country, CountryLanguage。

PHPMyAadmin 是最常用的管理 Mysql 数据库的网页工具。

请大家按照箭头所指顺序依次操作：

点击左侧 world 数据库，使之处于选中状态

点击主操作区 SQL 选项卡

在查询框中输入：

SELECT * FROM Country;

勾选保留查询框并点击执行按钮。

如果找不到 world 数据库，请大家根据下面操作步骤或视频演示，创建一个自己的练习数据库。

[下载数据链接](https://storage.yike.fm/demo/world.sql)

点击左侧数据库列表栏【新建】按钮，创建一个自己的数据库，这里我们命名为world_yike

点击主操作区【导入】选项卡，选择我们刚刚下载的world.sql文件，然后【执行】

首先解释一下刚刚我们执行的这条 SQL 语句。

SELECT * FROM Country;

SELECT 表示我们这句 SQL 是一个「选择查询」的操作。

*表示查询所有字段

FROM 表示从哪个表获取数据。

有一点英语基础的同学应该很容易理解这句话的意思：查出'Country'表中的所有记录。

后面的学习也请大家多结合单词的英文意思来理解。

Caoz：https://demo.phpmyadmin.net/

执行之后的结果如下图所示。

框出来的部分，就是我们的查询结果，列出了世界上所有国家/地区的名称，国土面积，人口等数据「应该是上个世纪末的数据」。

简单列一下我们后面会关注的字段的对照：

Name 国家/地区名称

Continent 洲

Region 区域(东亚，西欧等)

SurfaceArea 占地面积（平方公里）

IndepYear 独立年份

Population 人口

LifeExpectancy 预期寿命

GNP 国内生产总值（百万美元）

GovernmentForm 政府形式

Caoz：SELECT * FROM 表格名，可以列出所有该表格的内容。

Caoz：这里有两个概念，一个是字段，一个是记录行。

再看看上面浅黄色背景的执行信息：239 行，当前显示 0~24 行。

这里 phpMyAdmin 为了避免一次展示过多的信息，自动帮我们做了分页。

而实际使用中，数据库记录可能有上百万条，一次性全部查出来，是灾难性而且无意义的。所以我们需要对这种粗犷的查询方式做一些限制。

SELECT * FROM Country LIMIT 10;

增加一个 LIMIT 的限制，只读取 10 条记录。

要查看后面的数据怎么办呢。

SELECT * FROM Country LIMIT 10,5；

,前的10表示跳过前10条记录，也就是从第11条开始展示

,后的5表示一个展示5条数据

结合起来就是展示第11至15条

这里的,用来分隔LIMIT的两个控制参数：偏移量，展示行数。

Caoz：SQL 语言是一种标准数据库操作语言，不管是 mysql，oracle，还是 sql server，都可以使用 SQL 语言。

Caoz：但不同的数据库产品，在一些特殊的语法上有所不同，比如说，Limit，其实只是 MySQL特有的语法，而在其他数据库产品，有类似的语法，但格式不同。

这样我们就实现了一个简单的分页功能。

为了避免一次查询出过多的数据，在 SQL 后都带上一个 LIMIT 是个好习惯。

练习1：

请查询出 Country 表第 20~27 条记录。

我们的课程是可以永久回放的，听直播的同学，可以课后再练习，先跟完整个课程，有个整体的概念。

有听不明白的部分，可以在交流区或者我们后面的学习群提问。

除了行数太多会给我们带来困扰，字段太多也会分散我们的注意力。

如果现在只想看看各个国家/地区的面积和人口，就可以指定字段查询

SELECT Name,SurfaceArea,Population FROM Country LIMIT 10;

用明确的字段名Name,SurfaceArea,Population取代之前的*即可。

结果如下。

练习2:

请查询出 Country 表中的国家名和独立时间这两个字段的前 20 条数据。

## 2. 使用 WHERE 条件查询

到现在为止我们还只是在泛泛地浏览数据，接下来我们来学习怎样精确地查找。

请看下面的例子：

SELECT * FROM Country WHERE Name='China'

这里增加了WHERE子句，用来指定查询条件，也就是告诉数据库去哪里找数据，只有满足条件的数据才会被展示。

比如这里我们指明了只获取名称是China的数据记录。

WHERE 是SQL非常重要的一环，除了我们上面已经使用过的=等于外，还有以下方式。

> 大于
< 小于
<>不等于
>= 大于等于
<= 小于等于


BETWEEN 介于……之间

IN 从……中选择

LIKE 和……相似

下面再用几个例子展开讲一讲WHERE的常见用法。

查找独立时间在 1900 ~ 2000 间的国家。

SELECT * FROM Country WHERE IndepYear BETWEEN 1900 AND 2000;

BETWEEN AND 限制了IndepYear的范围是1900到2000之间（包含1900和2000）

我们也可以换一种表达方式：

SELECT * FROM Country WHERE IndepYear >= 1900 AND IndepYear <= 2000;

可以看出查询条件中包含了1900, 2000 这两个边界。

AND表示并列条件，需要同时满足前后两个子条件IndepYear >= 1900 和 IndepYear <= 2000

而与AND相对，OR表示只需要满足其中一个子条件。

比如，我们查询一下面积超过100万平方公里或者人口超过1亿的国家

SELECT * FROM Country WHERE SurfaceArea > 1000000 OR Population>100000000;

Caoz：上面的文字描述有错误。

Caoz：

SELECT * FROM Country WHERE IndepYear >= 1900 AND IndepYear <= 2000;

练习3：

请查询出人均寿命在80岁以上的记录


Caoz：

SELECT * FROM Country WHERE SurfaceArea >1000000 OR Population
<100000000;

当查询条件比较复杂的时候，我们需要用( )将他们括起来，还记得小学算术吗？

被括起来的部分优先判断，而且是被包裹在越里面的部分越优先。另外，由于只能使用小括号，大家写的时候可要仔细了，别看花了眼。

SELECT * FROM Country WHERE (SurfaceArea > 1000000 OR Population>100000000) AND (Continent='Asia' or Continent='Africa');

在上一个SQL的基础上，我们增加了限制：只查看亚洲和非洲的国家。

用两组括号划分了两个子条件。

面积大于100万平方公里，或者人口大于1亿

位于亚洲或者非洲

而这两个子条件是用AND连接的，所以只有同时满足这两个条件的数据才会出现在我们的查询结果中

Continent='Asia' OR Continent='Africa' 这的多选一条件，如果用OR来连接，会比较累赘，这种情况可以用IN来替换

SELECT * FROM Country WHERE (SurfaceArea > 1000000 OR Population>100000000) AND (Continent in ('Asia','Africa'));

是不是简单清楚多了。

刚才曹老师纠错主要是直播间对特殊字符做了转义，有显示异常的同学，可以刷新页面重试。

练习4：

请查询出位于亚洲或欧洲，并且人均寿命超过80岁的记录

而LIKE则可以用来做模糊匹配，比如我们要查询以字母A开头的国家/地区可以这样表达

SELECT * FROM Country WHERE Name LIKE 'A%';

%表示匹配任意内容，可以放在匹配模式的开头、中间或结尾。

LIKE 'A%'的意思就是以A开头文本内容。

练习5：

请从查询出国家名以stan结尾的记录

## 3. 使用 ORDER BY 排序

以上我们学习了如何定位数据，接下来我们将通过几个世界排行榜来看看如何加工数据。

首先是最长寿的国家/地区。

SELECT * FROM Country ORDER BY LifeExpectancy DESC LIMIT 10;

这里ORDER BY 表示按某个字段排序，而DESC(descend)表示排序的方式是从大到小的降序排列。如果想从小到大升序排列，请使用ASC(ascend)，如果不指定排序方向，默认为升序排列。

整句SQL的意思就是“对Country表按人均寿命倒序排列，取前10条记录”。

从上面的结果中我们可以看到

最长寿的是安道尔，位于南欧的一个袖珍国家

第二是中国澳门，第三是圣马力诺，也是南欧的一个袖珍国家

其余的大家应该都能自己看出来吧

练习6:

请查询出国土面积最小的10个国家/地区。

## 4. 使用 GROUP BY 分组

接下来让我们看看哪个洲的国家/地区最多。

由于我们的Country表每行记录了一个国家的数据，所以需要分别统计每个洲的记录数。

怎么数呢？

SELECT Continent,COUNT(*) FROM Country GROUP BY Continent;

这里出现新的操作：

COUNT(*)表示统计行数

GROUP BY表示按后面指定的字段来分组

结合起来就是“将Country中的记录按Continent分组，并统计每组的记录数”

注意，是先分组，再计数。

亚洲最多，51个

最少的是南极洲，只有5个

如果不加后面GROUP BY的限制，执行SELECT COUNT(*) FROM Country;，得到的结果会是Country表的总记录数。

练习7：

查询出各个政府形式(GovernmentForm)的国家/地区数。

如果我们想看看每个大洲的区域各有多少该怎么做呢？

直接count是不行的，我们需要对Region这个字段去重。

SELECT Continent, COUNT(DISTINCT Region) AS RegionNum FROM Country GROUP BY Continent;

大家可以自行尝试不加DISTINCT会有怎样的结果。

这里DISTINCT的意思是独立的，不同的，经过它的修饰，COUNT的对象，从简单的行数，变成了去重后的Region，从而得到我们想要的结果。

同时我们用AS将COUNT(DISTINCT Region)的结果赋予一个别名RegionNum便于识别

这个去重计数的操作，在日常的分析中，是经常使用的。

比如每日的活跃用户数，就可以通过对用户ID字段做去重计数来统计。

DISTINCT也可以单独使用，比如我们简单列出世界上有哪些洲。

SELECT DISTINCT Continent FROM Country;

练习8：

请查询出一共有多少个不同地区(Region)

## 5. SQL函数

接下来我们引入函数的概念:

函数就是对输入的数据进行加工的方法

计数方法COUNT就是一个我们常用的函数

此外，还有

求和SUM

求平均值AVG

最大值MAX

最小值MIN

四舍五入ROUND

等等

现在来看看如何利用求和函数SUM来计算每个洲的总人口。

SELECT Continent,SUM(Population) FROM Country GROUP BY Continent;

在上面两个例子中，我们虽然统计出了每个洲的国家数，人口数，但这些数据的排列仍然是杂乱的。

所幸洲的数量很有限。但能不能给这些被加工过的数据也排个序呢?

其实和原生字段的排序一样，我们可以指定衍生数据的排序方式。

SELECT Continent,COUNT(*) as CountryNum FROM Country GROUP BY Continent ORDER BY CountryNum DESC;

除了对单个字段的加工，也可以对多个字段做运算。

我们来看看各国家/地区的人均国民生产总值

SELECT Name, ROUND(GNP*1000000/Population, 2) AS PCGNP FROM Country ORDER BY PCGNP DESC LIMIT 10;
GNP/Population计算了每个国家的人均国民生产总值(Per Capita GNP),并通过ROUND函数四舍五入到2位小数。

*1000000是因为GNP原本的单位是百万美元，我们计算人均GNP的时候，需要将其还原为美元。

第一名卢森堡，大家有兴趣可以去查查这个国家为啥这么富裕。

练习9：
请查询每平方公里国民产值前10的国家/地区，单位美元，保留1位小数

我们也可以对文本内容做一些处理，比如来看看国家名首字母的分布情况

SELECT SUBSTRING(Name, 1, 1) AS FirstLetter, COUNT(*) AS Num FROM Country GROUP BY FirstLetter ORDER BY FirstLetter;
我们使用SUBSTRING这个函数来对Name字段做了截取，SUBSTRING(Name, 1, 1)第一个1表示从第一个字母开始，SUBSTRING(Name, 1, 1)第二个1表示截取的长度为1个字符。

练习10：

请查询出国家代码(Code)和国家名(Name)的前三个字符。

SQL还可以同时对多个字段做分组和排序。

比如上面统计了每个大洲的国家/地区数，现在我们将粒度拆细一点：统计每个区域的国家/地区数。

SELECT Continent,Region,COUNT(*) FROM Country GROUP BY Continent,Region;

GROUP BY后面可以跟指定多个字段，查询结果将依次逐级分组。

比如GROUP BY Continent,Region就表示先按洲分组，再按地区分组。

上面的结果还是有些凌乱，我们来做个复合排序：首先按洲名的字母表顺序排列，然后按每个区域的国家/地区数降序排列。

SELECT Continent,Region,COUNT(*) AS Num FROM Country GROUP BY Continent,Region ORDER BY Continent, Num DESC;

这里ORDER BY指明了排序规则。

首先按Continent升序排序（注意这里省略了Continent ASC 中的ASC）

如果Continent相同，就按COUNT得出的Num降序排列。

这样各个区域的国家/地区数是不是就一目了然了。

这里大家有对每一步的中间结果有预期，比如排序是在分组的结果上进行的。

练习11：

请查询每个大陆不同政府形式(GovernmentForm)的分布情况。

## 6. 对GROUP BY的结果做二次过滤

如果我们想进一步筛选，只展示国家/地区数超过10的部分，有没有办法呢？

注意，这里不能使用WHERE来限制，WHERE的判定只能以原表中的数据为基础，而分组后的统计数据Num是一个合并后产生的数据，对于这种情况，我们需要使用HAVING来过滤结果。

SELECT Continent,Region,COUNT(*) AS Num FROM Country GROUP BY Continent,Region HAVING Num>10 ORDER BY Continent, Num DESC ;

HAVING必须跟在GROUP BY 之后，ORDER BY之前（如果有的话），用来对分组计算结果做过滤。

练习12：

请查询出有超过5个国家独立的年份。

## 7. SQL完整结构

到此为止，SQL的查询语法SELECT我们基本就学习完了，可以归纳为下面的模板：

SELECT {column} FROM {table} WHERE {condition} GROUP BY {column} HAVING {condition} ORDER BY {column} LIMIT {offset,count}
SELECT为必须，其余都是可选项
{column}为列表达式，指定需要选择、过滤或操作的z字段，比如Name, GNP；也可以是表达式，比如count(*)
FROM 指定我们从哪里获得数据，一般是某张数据表
WHERE限制我们获取数据的条件，可用AND OR 以及 ( )来组合
{condition}为条件表达式，也就是Name='China'这样的判断语句
GROUP BY说明需要按哪些字段分组
HAVING 可以对分组后的结果做二次过滤
ORDER BY控制排序的方式，有升序ASC和降序DESC两种
LIMIT 限制显示的行数

## 曹大补充
Caoz：重复一下，Limit 不是标准SQL，是 Mysql 特有的语法

SQL语句以半角空格做分隔符，如果有, ( ) =等其他符号时可以省略空格

作为查找内容的文本，需要用' 或 " 包裹，比如where Name='China'中的'China'。

而数字不需要加引号，如IndepYear>=1900

SELECT FROM 这样，用于描述SQL语句结构的部分，我们称为关键字，是不区分大小写的，如果你高兴，完全可以这样写：

select * from Country limit 10;

字段名也不区分大小写的，但表名Country需要区分大小写（这里涉及操作系统的文件名大小写问题，不展开讲）

select name,gnp from Country limit 10;

为了保持一致性和规范性，大家在实际使用中，字段名最好保持和定义时一致的大小写。

Caoz：必须用半角符号，或者说英文字符的引号，如果使用全角字符，或者说中文引号，则会报错。

而关键字又称为保留字，SQL会将这些词作为结构指令来解析，而不允许在其他地方使用。

常见关键字有以下这些：

SELECT INSERT UPDATE DELETE CREATE FROM SHOW DESC KEY VALUE WHERE IN OR AND BETWEEN GROUP ORDER BY LIMIT

大家也不用刻意去记这些关键字，只有知道这些单词对于SQL来说有特殊的意义，一般不用于字段或表的命名即可。

上面主要讲了用于查询的SELECT语句，此外，还有用于创建数据库和数据表的CREATE语句，添加新数据的INSERT语句，更改数据的UPDATE语句，删除数据的DELETE语句，开发工程师就是通过这些增删改查的操作，来让数据库为我们的业务服务的。

这里讲一讲SQL的执行顺序：

首先是打开FROM指定的数据表

然后根据WHERE条件选取满足要求的数据行

接下进行GROUP BY分组，计数等操作

HAVING可以对GROUP BY的结果做二次过滤

ORDER BY对数据进行排序

最后通过LIMIT展示某几行

大家在写一条SQL语句之前，一定要想清楚你想得到什么样的结果。

如果这个数据查询工作不是交给机器，而是由你自己来做，你会按怎样的步奏来完成，你写出的SQL中是否给出了一个可执行的查询方案。

再简单介绍一些常用的SQL命令

显示当前的数据库列表

SHOW DATABASES;

访问指定的数据库

USE {dbname};

其中{dbname}是指定的数据库名

显示当前的数据表列表

SHOW TABLES;

显示指定的数据表基本格式

DESC {table};

其中{table}是指定的表名

大家可以自行尝试这些语句的效果

发现、分析问题

在数据分析中，除了掌握工具的用法，更重要的是要有发现问题、分析问题的思维能力。

下面，我们再看看能从这种Country表中发现什么？

比如表中有各国的独立时间，那我们来看看哪一年独立的国家最多呢？

SELECT IndepYear,COUNT(*) as Num FROM Country GROUP BY IndepYear ORDER BY Num DESC

第一行没有独立时间，因为表格中包含了香港、澳门这样的地区

而第二行、第三行是重点，1960、1991这两年独立的国家竟然有18个，远远超过其他年份，这两年发生了什么呢？

SELECT * FROM Country WHERE IndepYear=1960;

基本全是非洲国家，搜索一下，发现1960年被称为非洲独立年，有17个非洲国家在这一年独立，摆脱了殖民控制。

再来看看1991年

SELECT * FROM Country WHERE IndepYear=1991;

看看这一堆中东、东欧的“尼亚”国和“斯坦”国，不难想到是苏联解体的结果。

以上就是今天课程的主要内容，主要给大家一个初步的印象，能直接上手SQL。

想要进一步的学习，可以结合其他教程和手册进行。

比如菜鸟教程 http://www.runoob.com/sql/sql-tutorial.html 就很不错。

尤其是其中的函数部分 http://www.runoob.com/sql/sql-function.html，建议先通读，对SQL的函数有一个整体的了解，知道大致的效果，至于具体的用法可以等实际用到的时候再查。

练习题的答案，可在易灵微课公众号回复SQL0获取。

在看答案之前，还请先自己多多思考尝试。


Caoz：https://demo.phpmyadmin.net/ 是一个很好的可以公开测试的平台，每个人都可以上去测试数据库的查询，增加，删除，修改等操作。

phpMyAdmin 的演示服务器中，有一个名为 sakila 的影院数据库，大家可以自行探索。

Caoz：这样就免得看了很多描述不知道从哪里入手。那么这个数据库因为是全世界公开开放的，可能会定时清理数据，恢复原状，所以如果你操作一半发现数据被恢复了，不要觉得意外，继续尝试即可。

Caoz：我再多啰嗦几句，各位童鞋多呆一会。

1、关系型数据库是最常见的数据库，但世界上并不只有关系型数据库。

比如说，现在内存数据库特别火，redis，其实是非关系型数据库。

什么是关系型，数据表之间是存在某些关联的，比如我们做个学习管理系统，学生表，学生id，学生姓名，学生住址，学生入学时间，学生当前状态，在读啊，还是毕业啊。 这是第一个表

第二个表，课程表，课程id，课程名称，讲师id，课程时间，课程状态

第三个表，成绩表，学生id，课程id，课程成绩，考试类型，是期中，期末，还是补考，这样的。

那么你们看，学生信息，课程信息，成绩信息，可能还有一个讲师表，讲师信息，其实都是有关联的对不对。

如果你要获取完整的信息，其实需要多个表关联查询。

非关系型数据存储基本上就无法实现过于复杂的查询和关联处理，但检索效率更高，适用于特定场合。比如微博的信息队列，就是非关系型的数据存储。

那么我们看范例中的数据表，是两个维度，行，和列，列就是字段，行就是记录，和excel一样，这就是二维表。

但实际上还是有三维以及多维数据库存在的，所谓数据仓库，做数据分析的时候可能也会用到，不过目前并不常用，这里也是跟大家说一下。

https://yike.fm 网页版可以这里浏览

那么后面说一点稍微入门级可能用不到的东西，就是索引。

为什么有很多数据的时候，你要用数据库，而不是excel，你要用数据库存储和查询，而不是excel或文本文件存储和查询

以前也有很多文本文件为基础的应用，在早期互联网有的，后来基本淘汰了。

核心就是查询的效率，索引可以极大提高查询效率，简单说就是你输入一个查询条件的时候，无需遍历所有结果，可以通过索引快速命中你要的结果。

一个最容易的理解是，数据有序存储，折半查找，比如你读书去问老师成绩，老师有一沓卷子，老师怎么找呢。

这些卷子已经按照学号排序了，然后老师问你学号，问完了，往中间一翻，看你的学号是前面还是后面。

理论上，n条记录，找到你的记录，查询次数是log2(N)

这就是折半查找，日常最常见的应用，就不需要说每张卷子都看一下对不对。但前提是数据已经有序存储了。

为什么要强调这一段呢，我说过给一些零基础的童鞋，作为学习数据库优化的过度课程，这个理解索引，理解查询效率是数据库优化的第一步对不对。

如果你有n条记录，比如1000条，没有索引，没有排序，你要找一条记录，需要一条条翻，运气好只翻一次，运气不好翻1000次，平均500次对不对。

但如果你这1000条记录排序了，你用折半查找，其实log2(N),差不多10次就找到了，不管运气好不好，都不会超过10次。

实际数据索引大部分是btree结果，这个不展开了，b+tree， b-tree等等，不是完全的折半查找，但近似于折半查找。

SQL 是操作数据库的语言，python是计算机编程语言，python要操作数据库，也是先建立数据库链接，在执行SQL语言，然后把结果拿出来重新组织处理，再展示。

所以你用python也好，用php也好，用java也好，用其他什么开发语言也好，要操作数据库，要对关系型数据库做处理，都是要通过SQL语法来操作。

但有些语言可能会对SQL语法有一定的简单封装，这个不展开。

我以前在百度做数据分析用的全是mysql ,当然，百度业务线并不都是mysql，但我有数据处理能力，我会把原始数据先用脚本跑一遍然后塞到mysql再做二次处理。

数据并不都是数据库里出来的，有的是日志文件，有的是redis这样的非关系型数据库，但数据库应用最多，最广泛，也最普及。

谢谢大家支持，有问题请问，我大概要说的先这些。

多练习，多熟悉，SQL语言其实挺好懂得，不过优化就一眼望不到边了。

当你面对几千万条记录，需要快速做出分类排序统计的时候。。。

感谢曹老师的补充，感谢大家的支持！

课程中有12道练习题，答案回复易灵微课公众号 SQL0 可以查看

Caoz：[我的旧文](https://wenku.baidu.com/view/aa43ecc3aa00b52acfc7ca94?pcf=2&st=1)，可以看看


