# 数据库
    简而言之可视为电子化的文件柜——存储电子文件的处所，用户可以对文件中的数据进行新增、截取、更新、删除等操作。
    所谓“数据库”是以一定方式储存在一起、能予多个用户共享、具有尽可能小的冗余度、与应用程序彼此独立的数据集合。

 > [`✨Sql查询语句`](#sql查询语句)、[`✨数据库设计`](#数据库设计)[`(Mysql设计规范)`](mysql.md)、[`Sqlite`](sqlite.md)

## 数据库管理系统 [`Database's Tool`](https://github.com/angenalZZZ/doc-zip/blob/master/Database5Pro.7z "fishcodelib.com")、[`Navicat Premium`](https://www.jianshu.com/p/4113cd5ef139)
    Database Management System，简称`DBMS`，为管理数据库而设计的电脑软件系统，
    一般具有存储+截取+安全保障+备份等基础功能。数据库管理系统可以依据它所支持的数据库模型来作分类，例如`关系式`、`XML`
    或依据所支持的计算机类型来作分类，例如服务器群集、移动电话； 或依据所用查询语言来作分类，例如`SQL`、`XQuery`
    或依据性能冲量重点来作分类，例如最大规模、最高运行速度；亦或其他的分类方式。
    不论使用哪种分类方式，一些`DBMS`能够跨类别，例如，同时支持多种查询语言。

## 数据库类型

#### 关系数据库

- [MySQL](https://www.mysql.com "官网")

  - [MySQL Community Downloads](https://dev.mysql.com/downloads/ "下载")
  - [MySQL Enterprise Edition](https://www.mysql.com/cn/trials/ "购买") 提供了可扩展性、安全性、可靠性；降低了开发部署和管理的风险、成本和复杂性。
  - [MariaDB](https://github.com/MariaDB/server)（MySQL的代替品）
  - [Percona Server](https://github.com/percona/percona-server)（MySQL替代品）

- [Oracle](https://www.oracle.com "官网") 甲骨文公司软件产品

- [Microsoft SQL Server](https://www.microsoft.com/zh-cn/sql-server "官网") 微软推出的关系型数据库管理系统
  - [管理工具`SSMS-Setup-CHS`sql-server-management-studio](https://docs.microsoft.com/zh-cn/sql/ssms/download-sql-server-management-studio-ssms)

- [PostgreSQL](https://www.postgresql.org "官网") 世界上最先进的开源关系数据库

 几乎所有的数据库管理系统都配备了一个开放式数据库连接（ODBC）驱动程序，令各个数据库之间得以互相集成。

#### 非关系型数据库（NoSQL）

- [BigTable（Google）](https://cloud.google.com/bigtable "官网") 分布式数据存储系统，可扩展到PB级数据和上千台服务器
- [CouchDB](http://couchdb.apache.org "官网") 下一代Web应用存储系统
- [MongoDB](https://www.mongodb.org.cn "官网") 基于分布式文件存储的数据库

#### 内存数据库 | 键值（key-value）数据库

- [Redis（Salvatore Sanfilippo）](https://github.com/angenalZZZ/doc/blob/master/redis缓存服务.md)[(查询文档)](http://www.redis.cn)
- [Rocksdb（Facebook）](https://github.com/facebook/rocksdb/blob/master/LANGUAGE-BINDINGS.md)
- [LevelDB（Google）](https://github.com/google/leveldb)

----

## 数据库模型

- 对象模型
- 层次模型（轻量级数据访问协议）
- 网状模型（大型数据储存）
- 关系模型
- 面向对象模型
- 半结构化模型
- 平面模型（表格模型，一般在形式上是一个二维数组；如表格模型数据Excel)

#### 数据库架构

数据库的架构可以大致区分为三个概括层次：内层、概念层和外层。

- 内层：最接近实际存储体，亦即有关数据的实际存储方式。
- 外层：最接近用户，即有关个别用户观看数据的方式。
- 概念层：介于两者之间的间接层。

#### 数据库索引

    数据索引的观念由来已久，像是一本书前面几页都有目录，目录也算是索引的一种，只是它的分类较广，
    例如车牌、身份证字号、条码等，都是一个索引的号码，当我们看到号码时，可以从号码中看出其中的端倪，
    若是要找的人、车或物品，也只要提供相关的号码，即可迅速查到正确的人事物。

    另外，索引跟字段有着相应的关系，索引即是由字段而来，其中字段有所谓的关键字段（Key Field），该字段具有唯一性，
    即其值不可重复，且不可为空值`null`。例如：在合并数据时，索引便是扮演欲附加字段数据之指向性用途的角色。
    故此索引为不可重复性且不可为空。

#### 数据库事务

事务（transaction）是用户定义的一个数据库操作序列，这些操作要么全做，要么全不做，是一个不可分割的工作单位。 事务的ACID特性：

 * 基元性（atomicity）
 * 一致性（consistency）
 * 隔离性（isolation）
 * 持续性（durability）

事务的并发性是指多个事务的并行操作轮流交叉运行，事务的并发可能会访问和存储不正确的数据，破坏交易的隔离性和数据库的一致性。

网状数据模型的数据结构 网状模型 满足下面两个条件的基本层次联系的集合为网状模型。 

 1. 允许一个以上的结点无双亲； 2. 一个结点可以有多于一个的双亲。

----

#### SQL查询

 * `DDL`（data definition language）数据库定义语言
    * 定义表的结构，数据类型，表之间的链接和约束，包括（CREATE、ALTER、DROP等）
 * `DCL`（Data Control Language）数据库控制语言
    * 设置数据库用户或角色权限的语句，包括（grant,deny,revoke等）
 * `DML`（data manipulation language）数据操纵语言
    * 对数据库的数据进行一些操作，包括（SELECT、UPDATE、INSERT、DELETE等）
 * `SQL优化` & `IO优化(Network&Disk)` 
	* 用索引index提高查询效率，替换`NULL`字段为`NOT NULL`并设置默认值 
	* 避免在index索引列上使用`函数`、`IS NULL`、`OR`等 导致全表扫描 
	* 避免在where中使用`OR`，应该将`OR`使用`UNION`进行改写 
	* 避免在where中使用`1=1`、`!=`、`<>`、`like '%abc%'`，不要用`order by rand()` 导致全表扫描 
	* 模糊查询时like尽量使用后置匹配`like 'abc%'`才会走索引 避免全表扫描
 	* 用表连接join替换exists; 用exists替代distinct; 用exists替代in; 用not exists替代not in 
	* 尽量使用表变量`with t as()`代替临时表`select into t from`，临时表常用于定时任务 
	* 临时表插入数据量大时-用`select into`代替`create table`，数据量少时反之
	* 临时表用于一些重复的数据筛选大数据表，删除或清空t前-先进行`truncate table` 
	* 把IP地址存成 `unsigned int` 在where条件语句 `IP between ip1 and ip2` 
	* 拆分大事务操作，设计时进行表分区、分表、分库等，从而提高系统并发能力
 * `SQL执行顺序`
~~~sql
  (8) SELECT (9)DISTINCT (11)<Top Num> <available_columns_list> -- 减少数据除重、无效字段的数据查询
  (1) FROM [left_table]               -- 选取表，将多个表数据通过笛卡尔积变成一个虚表
  (3) <join_type> JOIN <right_table>  -- 用于添加筛选数据到虚表中，例如left_join会将左表的剩余数据添加到虚表
  (2)             ON <join_condition> -- 对于添加筛选数据的虚表进行筛选
  (4) WHERE <where_condition>    -- 对上述虚表进行筛选,减少用聚合函数,最大化利用索引; 不直接支持<join_type>临时表(可用于过滤该临时表)
  (5) GROUP BY <group_by_list>   -- 分组可用HAVING子句进行分组筛选
  (6) WITH <CUBE | RollUP | NOLOCK ...> -- 选取表查询规则
  (7) HAVING <having_condition>  -- 可用聚合函数sum,avg,count...进行聚合筛选
  (10)ORDER BY <order_by_list>   -- 排序条件,减少用聚合函数
~~~

~~~sql
/* 过滤数据 Filtering Data */
SELECT name FROM users WHERE gender = 1 AND (age BETWEEN 20 AND 30) AND country IN ('CHINA','USA')
/* 日期时间 Date and Time */
 -- MySQL
SELECT name,DATE_FORMAT(birthday,'%Y-%m-%d') FROM users WHERE YEAR(birthday)=YEAR(now())
 -- Oracle
SELECT name,to_char(birthday,'YYYY-MM-DD') FROM users WHERE age = 20

/* 分页数据 Limiting Results */
 -- MySQL,PostgreSQL,SQLite
SELECT name FROM users LIMIT 5           -- 只取前5条
SELECT name FROM users LIMIT 5, 5        -- 从第6条取到第10条
 -- MsSQL, Access
SELECT TOP 5 name FROM users             -- 只取前5条
SELECT name FROM users ORDER BY id OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY -- 从第6条取到第10条 MsSQL^2012
 -- Oracle
SELECT name FROM users WHERE ROWNUM <= 5 -- 只取前5条
SELECT * FROM (SELECT ROWNUM AS rn, * FROM users 
    WHERE hire_date BETWEEN TO_DATE('20060701','yyyymmdd') AND TO_DATE('20060731', 'yyyymmdd')
    AND ROWNUM <= 20) AS t
    WHERE t.rn >= 10;
 -- Firebird,Interbase
SELECT name FROM users ROWS 5            -- 只取前5条
SELECT name FROM users ROWS 6 TO 10      -- 从第6条取到第10条
 -- DB2
SELECT name FROM users FETCH FIRST 5 ROWS ONLY -- 只取前5条

 -- SQLServer 记录的加法
SELECT name FROM users1 
union                                    -- `union`不包含重复行，`union all`包含重复行
SELECT name FROM users2

SELECT name FROM users1 
intersect                                -- `intersect`选取表的公共记录
SELECT name FROM users2

 -- SQLServer 记录的减法
SELECT name FROM users1 
except                                   -- `except`减数与被减数
SELECT name FROM users2

 -- SQLServer 记录的合并
MERGE INTO Courses AS T -- 目标:源表-课程
USING (SELECT Id,Name,CreateUserId,CreateUserName FROM TMP_Courses) AS S -- 来源:新增临时表-课程
ON S.Name=T.Name -- 比较:关系条件; 避免重复添加记录:
WHEN MATCHED THEN -- 以前添加过的进行更新
	update set T.LastUpdateTime=getdate()
WHEN NOT MATCHED THEN -- 以前没有添加过的进行新增
	insert values(newid(),S.Name,S.CreateUserId,S.CreateUserName); -- 结束合并;

 -- SQLServer 窗口函数 即 OLAP 实时分析处理函数(online analytical processing)
 -- :聚合函数sum,avg,count,max.. :专用函数<row_number,rank..> over([partition by <列清单>] order by <列清单>)
SELECT name, row_number() over(order by score desc) FROM scores -- `row_number`可用于分页但效率一般!
SELECT name, ntile(3) over(order by score desc) FROM scores -- `ntile`排序后进行评分[分区n=3表示上中下3组]
SELECT name, rank() over(partition by name order by income desc) FROM users -- `rank`跳跃排名:1,2,2,4
SELECT name, dense_rank() over(partition by name order by income desc) FROM users -- `dense_rank`连续排名1,2,2,3
SELECT pid,name,avg(price) over(order by pid rows 2 preceding) FROM products -- 截至2之前两行求平均
SELECT pid,name,avg(price) over(order by pid rows 2 following) FROM products -- 截至2之后汇总再求平均
SELECT pid,name,avg(price) over(order by pid rows between 20 preceding and 10 following) FROM products -- 10~20
SELECT type, sum(income) as income_sum from products group by rollup(type) -- 同时得到合计和小计
SELECT grouping(type),grouping(year), sum(income) from products group by rollup(type,year) -- 当null时自动转0
SELECT type,year, sum(income) from products group by cube(type,year) -- 搭积木(把所有可能的组合)汇总到一个结果中

 -- MySQL 使用DECODE函数来减少处理时间(避免重复扫描相同的表或记录)
SELECT COUNT(DECODE(type,'1',1,NULL)) typeCount1, COUNT(DECODE(type,'2',1,NULL)) typeCount2, 
       AVG(DECODE(type,'1',price,NULL)) priceAvg1, AVG(DECODE(type,'2',price,NULL)) priceAvg2 
FROM products 

~~~

#### SQL查询语句

> [`MySQL`](https://www.mysql.com) ~ `sql语句`
~~~sql
# 安装数据库
$ sudo apt-get update
$ sudo apt-get install mysql-server  # 默认版本 <CentOS7> sudo yum install mariadb mariadb-server
$ sudo mysql_secure_installation     # 安装配置
$ sudo systemctl status mysql        # 检查状态
$ sudo systemctl enable mysql        # 开机启动
$ ps aux |grep mysqld　　　　　       # 查看进程 /usr/sbin/mysqld --daemonize --pid-file=/run/mysqld/mysqld.pid
$ cat /etc/mysql/debian.cnf          # 查看系统密码
$ mysql -u debian-sys-maint -p       # 准备修改密码
> use mysql;
> update mysql.user set authentication_string=password('root') where user='root'; # and Host ='localhost';
> update user set plugin="mysql_native_password";
> flush privileges; quit;
$ sudo service mysql restart          # 重启 systemctl restart mysql
$ mysql -P3306 -uroot -p < init.sql   # 以root身份登录并执行脚本> source init.sql
# 创建数据库<db>字符集编码为utf8
> create database <db> default character set utf8 collate utf8_bin;
# 创建用户并授权
CREATE USER 'unknown'@'localhost' IDENTIFIED BY '******';     # 创建本地用户unknown密码******
CREATE USER 'unknown'@'192.168.10.10' IDENTIFIED BY '******'; # 创建远程用户unknown密码******
# 配置远程访问 (@'localhost'本机访问; @'%'所有主机都可连接)
> CREATE USER 'newuser'@'%' IDENTIFIED BY '******';  # 创建远程用户newuser密码******
> select * from user where user='newuser' \G;        # 查询当前用户: SELECT USER();
> grant select,insert,update,delete,create,drop,index,alter on dbname.* to newuser@192.168.10.10 identified by '******';
> GRANT ALL PRIVILEGES ON *.* TO root@localhost IDENTIFIED BY '******';    # 默认root授权对所有db本地操作权限(限制本地访问)
> GRANT ALL PRIVILEGES ON <db>.* TO 'newuser'@'%' IDENTIFIED BY '******';  # 授权用户newuser对指定<db>所有的操作权限
-- GRANT EXECUTE, PROCESS, SELECT, SHOW DATABASES, SHOW VIEW, ALTER, ALTER ROUTINE, CREATE, CREATE ROUTINE, \
--   CREATE TABLESPACE, CREATE TEMPORARY TABLES, CREATE VIEW, DELETE, DROP, EVENT, INDEX, INSERT, REFERENCES, \
--   TRIGGER, UPDATE, CREATE USER, FILE, LOCK TABLES, RELOAD, REPLICATION CLIENT, REPLICATION SLAVE, SHUTDOWN, \
--   SUPER ON <db>.* TO 'unknown'@'%' WITH GRANT OPTION; # 授权用户unknown对指定<db>指定的操作权限
-- GRANT USAGE ON <db>.* TO 'unknown'@'localhost';       # 限制用户unknown只能本地访问<db>
-- GRANT PROXY ON ''@'' TO 'unknown'@'localhost' WITH GRANT OPTION; # 代理授权访问
> SET PASSWORD FOR 'root'@'%' = PASSWORD('******');      # 设置密码为root
> mysqladmin -u root password 123456                     # 初始化密码
> mysqladmin -u root -p 123456 password HGJ766GR767FKJU0 # 修改密码
> mysqladmin -u root -p shutdown                         # 关闭mysql
~~~

> [`MSSQLServer`](https://www.microsoft.com/zh-cn/sql-server) ~ `sql语句` ~ [`github.com/microsoft/sql-server-samples`](https://github.com/microsoft/sql-server-samples)
  - [Wide World Importers sample database v1.0](https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0) 展现 SQL Server2016 和 Azure SQL Database 的主要示例。 它同时包含OLTP和OLAP数据库。
  - [In-Memory OLTP Performance Demo v1.0](https://github.com/Microsoft/sql-server-samples/releases/tag/in-memory-oltp-demo-v1.0) 展现 SQL Server 和 Azure SQL Database 中的内存OLTP技术的性能优势。
  - [IoT Smart Grid sample v1.0](https://github.com/Microsoft/sql-server-samples/releases/tag/iot-smart-grid-v1.0) 如何利用 SQL Server 从 IoT 设备和传感器获取数据，以及如何对这些数据进行分析。
  - [数据安全性/加密/加密数据列](https://docs.microsoft.com/zh-cn/sql/relational-databases/security/encryption/encrypt-a-column-of-data)
~~~sql
-- SQLServer版本
SELECT @@VERSION -- Enterprise Edition、Standard Edition、Developer Edition
-- --支持2012以上版本
-- -- ALTER DATABASE dbname SET COMPATIBILITY_LEVEL = 110
-- --查看内存
-- -- dbcc memorystatus
-- --查看进程
SELECT dbid,db_name(dbid) as dbname,* from sys.sysprocesses order by db_name(dbid)
-- --查看当前的数据库用户连接有多少
DECLARE @dbname varchar(50)='testDb'
SELECT dbid,db_name(dbid) as dbname,* from sys.sysprocesses where dbid=db_id(@dbname)
SELECT @@CPU_BUSY as CPU_BUSY, @@CONNECTIONS as CONNECTIONS, @@TOTAL_READ as TOTAL_READ, @@TOTAL_WRITE as TOTAL_WRITE,
[DB_name]=@dbname,[DB_processes]=(SELECT COUNT(*) FROM sys.sysprocesses WHERE dbid=db_id(@dbname))
-- --SELECT * FROM sys.dm_exec_sessions WHERE database_id=db_id(@dbname) ORDER BY total_elapsed_time DESC
-- --SELECT bucketid,sql,sqlbytes,objtype FROM sys.syscacheobjects WHERE dbid=db_id(@dbname) ORDER BY bucketid DESC

-- --查看CPU占用高的20条语句(10分钟内) 
SELECT TOP 20 db_name(qp.dbid) [db_name], last_execution_time, 
 (SELECT SUBSTRING(text,statement_start_offset/2+1,(CASE WHEN statement_end_offset=-1 THEN LEN(CONVERT(nvarchar(max),text))*2 
 ELSE statement_end_offset END - statement_start_offset)/2) FROM sys.dm_exec_sql_text(sql_handle)) [sql], 
 total_worker_time/execution_count [avg_cpu], total_elapsed_time/execution_count [avg_time], execution_count [count] 
FROM sys.dm_exec_query_stats qs CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) as qp 
WHERE last_execution_time>DATEADD(MINUTE,-10,GETDATE()) ORDER BY [avg_cpu] DESC

-- --查看最近执行的20条语句
SELECT TOP 20 db_name(qp.dbid) [db_name], last_execution_time, 
 (SELECT SUBSTRING(text,statement_start_offset/2+1,(CASE WHEN statement_end_offset=-1 THEN LEN(CONVERT(nvarchar(max),text))*2 
 ELSE statement_end_offset END - statement_start_offset)/2) FROM sys.dm_exec_sql_text(sql_handle)) [sql], 
 total_worker_time/execution_count [avg_cpu], total_elapsed_time/execution_count [avg_time], execution_count [count] 
FROM sys.dm_exec_query_stats qs CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) as qp 
ORDER BY [last_execution_time] DESC


-- --查看数据库表结构
SELECT tbl.name AS [TABLE_NAME], SCHEMA_NAME(tbl.schema_id) AS [TABLE_SCHEMA], 
 CAST(case when tbl.is_ms_shipped=1 then 1 when(select major_id from sys.extended_properties where major_id=tbl.object_id 
  and minor_id=0 and class=1 and name=N'microsoft_database_tools_support') is not null then 1 else 0 end AS bit) AS [IsSystemObject] 
FROM sys.tables AS tbl ORDER BY tbl.name;
-- --查看存储过程结构
SELECT cast(xp.[value] as nvarchar(4000)) 
FROM ::fn_listextendedproperty(NULL,N'Schema',N'dbo',N'Procedure',N'proc_import_to_efi_mall_fei_billapply',NULL,NULL) xp 
WHERE xp.name in (N'MS_Description')


-- --日期时间-- https://www.aliyun.com/jiaocheng/1399735.html
-- https://docs.microsoft.com/en-us/sql/t-sql/functions/current-timestamp-transact-sql?view=sql-server-2017#examples
SET DATEFIRST 1; SELECT @@DATEFIRST [星期一为每周第一天];
SELECT SYSDATETIME(), SYSDATETIMEOFFSET()  -- 时区offset +08:00
SELECT SYSUTCDATETIME(), CURRENT_TIMESTAMP -- UTC时间, 时间戳timestamp等价于getdate()
SELECT GETDATE(), GETUTCDATE()             -- 当前本地时间getdate(), UTC时间戳
-- --时间取值-- DateAdd,DateDiffl; DateName,DatePart;
-- -- 年 yyyy,yy 季度 qq,q 月 mm,m 年中的日 dy,y 日 dd,d 周 wk,ww 星期 dw,w,weekday
-- -- 时 hh 分 mi,n 秒 ss,s 毫秒 ms 微妙 mcs 纳秒 ns

SELECT IsDate('2020-01-01') -- 是否为有效时间
SELECT DateFromParts(2020,1,1) -- 支持2012以上版本
SELECT EOMONTH(DateFromParts(2020,1,1)) -- 所在月份最后一天 2020-1-31
select dateadd(mm,datediff(mm,0,getdate()),0) -- 本月第一天
select dateadd(wk,datediff(wk,0,getdate()),0) -- 本周星期一
select dateadd(yy,datediff(yy,0,getdate()),0) -- 今年第一天
select dateadd(qq,datediff(qq,-1,getdate()),0) -- 下个季度第一天
select dateadd(dd,-day(getdate()),getdate()) -- 上个月最后一天
select dateadd(year,datediff(year,0,dateadd(year,1,getdate())),-1) -- 今年最后一天
select dateadd(year,-1,getdate()) -- 去年同一天

SELECT CONVERT(varchar(23),getdate(),121) as [完整日期时间], CONVERT(varchar(8),getdate(),112) as [日期] -- 21 or 121 | yyyy-mm-dd hh:mi:ss:mmm(24小时制)
SELECT CONVERT(varchar(19),getdate(),120) as [日期时间], CONVERT(varchar(10),getdate(),20) as [日期]    -- 20 or 120 | yyyy-mm-dd hh:mi:ss(24小时制)
SELECT CONVERT(varchar(10),getdate(),108) as [时间], CONVERT(varchar(14),getdate(),114) as [时间ms]

IF EXISTS(SELECT TOP 1 * FROM sysobjects WHERE id=OBJECT_ID(N'datepartf') AND type='FN') DROP FUNCTION datepartf

CREATE FUNCTION dbo.datepartf(@Source nvarchar(20),@PaddingChar nchar(1),@TotalWidth tinyint) RETURNS nvarchar(20) 
AS BEGIN DECLARE @Result nvarchar(20) SELECT @Result = REPLICATE(@PaddingChar, @TotalWidth - LEN(@Source)) + @Source RETURN @Result END

SELECT dbo.datepartf(datepart(yyyy, getdate()),'0',4)+'-'
	+dbo.datepartf(datepart(mm, getdate()),'0',2)+'-'
	+dbo.datepartf(datepart(dd, getdate()),'0',2)

SELECT datediff(dd,'2018-12-31',getdate()) as [相差几天]


-- --加密MD5--
SELECT MD5=(LOWER(SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('MD5','123456789')), 3, 32)))
-- --随机字符--
SELECT CAST(CAST(CRYPT_GEN_RANDOM(16) AS UNIQUEIDENTIFIER) AS CHAR(36)) UUID_32
SELECT UPPER(sys.fn_varbintohexsubstring(0,CRYPT_GEN_RANDOM(16),1,12)) UUID_24
SELECT UPPER(RIGHT(CAST(sys.fn_varbintohexstr(CRYPT_GEN_RANDOM(10)) AS VARCHAR(36)),16)) UUID_16
-- --随机整数--
SELECT ABS(CONVERT(bigint,CRYPT_GEN_RANDOM(16))), ABS(CONVERT(bigint,CONVERT(varbinary,CRYPT_GEN_RANDOM(16),1)))


-- ------------------------------------------
-- 通过简单对称加密进行加密(建议 SQL Server 2012 - 11.x)
-- https://docs.microsoft.com/zh-cn/sql/relational-databases/security/encryption/create-a-database-master-key
USE master;
-- 查询/哪些数据库已加密
SELECT top 10 name FROM sys.databases where is_master_key_encrypted_by_server=1;
SELECT DB_NAME(database_id) as name,encryption_state FROM sys.dm_database_encryption_keys where encryption_state>0;
-- 查询/密钥信息
SELECT * FROM sys.symmetric_keys;
-- ------------------------------------------
-- 创建/主密钥(主数据库)
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'a7hxJ#KL95234nl0zBe';
-- 修改/主密钥
ALTER MASTER KEY REGENERATE WITH ENCRYPTION BY PASSWORD = 'a7hxJ#KL95234nl0zBe';
-- 备份/主密钥
OPEN MASTER KEY DECRYPTION BY PASSWORD = 'a7hxJ#KL95234nl0zBe'; -- 备份/还原(前提:打开主密钥的自动解密功能)
BACKUP MASTER KEY TO FILE = 'C:\db\masterkey.bak' ENCRYPTION BY PASSWORD = 'K95234nl';
-- 创建/加密证书(主数据库)
CREATE CERTIFICATE Cer_Protection WITH SUBJECT = 'Database Protection';
-- 备份/证书
BACKUP CERTIFICATE Cer_Protection TO FILE = 'C:\db\mastercert.cer' 
	WITH PRIVATE KEY (FILE = 'C:\db\mastercert.pvk', ENCRYPTION BY PASSWORD = 'K95234nl')
-- ------------------------------------------
-- 还原/主密钥
RESTORE MASTER KEY FROM FILE = 'C:\db\masterkey.bak' DECRYPTION BY PASSWORD = 'K95234nl'
	ENCRYPTION BY PASSWORD = 'a7hxJ#KL95234nl0zBe';
-- 还原/证书
CREATE CERTIFICATE Cer_Protection FROM FILE = 'C:\db\mastercert.cer' 
	WITH PRIVATE KEY (FILE = 'C:\db\mastercert.pvk', DECRYPTION BY PASSWORD = 'K95234nl')
-- 还原/数据库(附件db)
CREATE DATABASE db_encryption_test
ON PRIMARY(FILENAME=N'C:\db\encrypted.mdf') LOG ON (FILENAME=N'C:\db\encrypted_log.ldf') FOR ATTACH;
-- ------------------------------------------

-- 1.加密数据库 (TDE对称密钥/用户数据库) 防止db文件被还原
USE db_encryption_test; -- 先打开用户数据库
-- 生产环境1.创建/DEK数据库加密密钥
CREATE DATABASE ENCRYPTION KEY WITH ALGORITHM = AES_256 ENCRYPTION BY SERVER CERTIFICATE Cer_Protection;
-- 生产环境2.设置成单用户在运行
USE master;
ALTER DATABASE db_encryption_test SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- 生产环境3.开启TDE加密(先备份)
ALTER DATABASE db_encryption_test SET ENCRYPTION ON;
-- 生产环境4.设置成多用户访问
ALTER DATABASE db_encryption_test SET MULTI_USER WITH ROLLBACK IMMEDIATE;
-- 验证环境5.成功开启TDE加密 encryption_state=3 
SELECT DB_NAME(database_id) as name,encryption_state FROM sys.dm_database_encryption_keys where encryption_state>0;
-- ------------------------------------------

-- 2.加密数据列 (TDE对称密钥/用户数据库) 防止db数据被盗取
-- https://docs.microsoft.com/zh-cn/sql/relational-databases/security/encryption/encrypt-a-column-of-data
USE EE2WAPXB_Encrypted; -- 先打开用户数据库
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'a7hxJ#KL95234nl0zBe';
-- 创建/加密证书(用户数据库)
OPEN MASTER KEY DECRYPTION BY PASSWORD = 'a7hxJ#KL95234nl0zBe'; -- 创建/证书与密钥(前提:打开主密钥)
CREATE CERTIFICATE Cer_Protection WITH SUBJECT = 'Database Protection';
CREATE SYMMETRIC KEY Key_Protection WITH ALGORITHM = AES_256 ENCRYPTION BY CERTIFICATE Cer_Protection; -- 创建/对称加密密钥(用户数据库)
CREATE TABLE T_Encrypted (
	Id varchar(36) NOT NULL PRIMARY KEY CLUSTERED, 
	QueryStr nvarchar(30) NOT NULL, 
	EncryptStr VARBINARY(MAX) NOT NULL, 
	CreateUser char(36) NOT NULL, 
	CreateTime datetime NOT NULL DEFAULT (getdate()), 
	LastUpdateUser char(36), 
	LastUpdateTime datetime NOT NULL DEFAULT (getdate()), 
	DeleteMark bit NOT NULL DEFAULT (0),
	DeleteUser varchar(36), 
	DeleteTime datetime
);
-- 新增:加密数据
OPEN SYMMETRIC KEY Key_Protection DECRYPTION BY CERTIFICATE Cer_Protection; -- 开启加密功能
INSERT INTO T_Encrypted(Id,QueryStr,EncryptStr,CreateUser)
VALUES(lower(newid()),'关键词',EncryptByKey(Key_GUID('Key_Protection'), N'{"name":"店小二"}'),'730BD098-1E53-49EB-ACE1-7174EEC76692');
-- 查询:解密数据
OPEN SYMMETRIC KEY Key_Protection DECRYPTION BY CERTIFICATE Cer_Protection; -- 开启解密功能
SELECT Id, QueryStr,EncryptStr,CONVERT(nvarchar,DecryptByKey(EncryptStr)) AS 'DecryptedStr' FROM T_Encrypted;  
-- ------------------------------------------



-- --游标--
declare @id int
declare cursor1 cursor for
SELECT [id] FROM [TABLE_NAME]

open cursor1
fetch next from cursor1 into @id
while @@fetch_status=0
BEGIN
	-- begin --
	-- end ----
	fetch next from cursor1 into @id
END
close cursor1
deallocate cursor1


-- --动态sql--
EXEC SP_EXECUTESQL @STMT=N'SELECT * FROM sys.databases WHERE compatibility_level=@level ORDER BY name',@PARMS=N'@level tinyint',@level=110


-- --哪个过程引起了阻塞block?
-- -- exec sp_who active
-- --锁住了哪些资源?
-- -- exec sp_lock

-- --查看被锁语句--
-- -- select request_session_id spid,OBJECT_NAME(resource_associated_entity_id) tableName from sys.dm_tran_locks where resource_type='OBJECT'
-- --查看被锁表--
-- -- select b.text,a.* from master..SysProcesses a cross apply sys.dm_exec_sql_text(sql_handle) b where db_Name(a.dbID)='FEI_MALL' and a.spId<>@@SpId

-- --查看锁<锁模式>
-- --共享 (S) 用于不更改或不更新数据的操作（只读操作），如 SELECT 语句
-- --更新 (U) 用于可更新的资源中。防止当多个会话在读取、锁定以及随后可能进行的资源更新时发生常见形式的死锁
-- --排它 (X) 用于数据修改操作，例如 INSERT、UPDATE 或 DELETE。确保不会同时同一资源进行多重更新
-- --意向锁 用于建立锁的层次结构。意向锁的类型为：意向共享 (IS)、意向排它 (IX) 以及与意向排它共享 (SIX)
-- --架构锁 在执行依赖于表架构的操作时使用。架构锁的类型为：架构修改 (Sch-M) 和架构稳定性 (Sch-S)
-- --大容量更新 (BU) 向表中大容量复制数据并指定了 TABLOCK 提示时使用
select str(request_session_id,4,0) as spid,convert(varchar(20),db_name(resource_database_id)) as [db_name],case when resource_database_id = db_id() and resource_type='OBJECT' then convert(char(20), object_name(resource_Associated_Entity_id)) else convert(char(20), resource_Associated_Entity_id) end as [资源],convert(varchar(12), resource_type) as resrc_type,convert(varchar(12), request_type) as req_type,convert(char(3), request_mode) as [锁模式],convert(varchar(8), request_status) as status from sys.dm_tran_locks
where resource_database_id=db_id('testDb') order by request_session_id desc
-- --看到当前那个表有锁--------------------------------------------------------
select request_session_id sessionid,resource_type type,convert(varchar(20), db_name(resource_database_id)) as [db_name],OBJECT_NAME(resource_associated_entity_id, resource_database_id) tbl_name,request_mode [锁模式],request_status rstatus from sys.dm_tran_locks
where resource_database_id=db_id('testDb') and resource_type='OBJECT' order by request_session_id desc
-- --解除锁--------------------------------------------------------------------
declare @spid int
declare @sql varchar(1000)
declare cursor1 cursor for
select spid from master.sys.sysprocesses where dbid=db_id('FEI_MALL') and spid<>@@spid
open cursor1
fetch next from cursor1 into @spid
while @@fetch_status=0
BEGIN
set @sql='kill '+cast(@spid as varchar)
exec(@sql)
fetch next from cursor1 into @spid
END
close cursor1
deallocate cursor1


-- --查看当前的存放位置 
select * from sys.master_files
select database_id,name,physical_name AS CurrentLocation,state_desc,size from sys.master_files
where database_id=db_id(@dbname)

-- --修改文件的存放位置下次启动生效
-- --testDb为数据库名，
alter database 数据库名 modify file ( name = 文件名(不包含后缀), filename = '文件存储路径')
alter database 数据库名 modify file ( name = 文件名(不包含后缀), filename = '文件存储路径')
-- --eg. 例如
alter database testDb modify file ( name = testDb, filename = 'G:\SQL_DATA\testDb\testDb.mdf')
alter database testDb modify file ( name = testDb_log, filename = 'G:\SQL_DATA\testDb\testdb_log.ldf')

-- --修改默认的数据库文件存放位置 即时生效
EXEC xp_instance_regwrite @rootkey='HKEY_LOCAL_MACHINE', @key='Software\Microsoft\MSSQLServer\MSSQLServer', 
 @value_name='DefaultData', @type=REG_SZ, @value='E:\MSSQL_MDF\data' 

-- --修改默认的日志文件存放位置 即时生效
EXEC master..xp_instance_regwrite @rootkey='HKEY_LOCAL_MACHINE', @key='Software\Microsoft\MSSQLServer\MSSQLServer', 
@value_name='DefaultLog', @type=REG_SZ, @value='E:\MSSQL_MDF\log' 


-- --查询数据库权限
SELECT DISTINCT class_desc FROM fn_builtin_permissions(default) ORDER BY class_desc
SELECT * FROM fn_my_permissions(NULL, 'SERVER')
SELECT * FROM fn_my_permissions(NULL, 'DATABASE')


-- --链接外部服务器-->创建链接别名
exec sys.sp_addlinkedserver '链接别名','数据库类型','SQLOLEDB','远程服务器名或ip地址' -- 数据库类型为空时-默认:sqlserver
exec sys.sp_addlinkedsrvlogin '链接别名','false',null,'用户名','密码'
-- --select * from 链接别名.数据库名.dbo.表名
exec sys.sp_droplinkedsrvlogin '数据库名',null
exec sys.sp_dropserver '数据库名'


-- --合并查询/逗号分隔结果
select (stuff((select ','+a.UserName from HonorUser u inner join UserAccount a on u.UserId=a.Id where u.HonorId='1' for xml path('')),1,1,''))


-- --字符集
-- --制表符: CHAR(9)
-- --换行符: CHAR(10)
-- --回车符: CHAR(13)
-- ---------行转列---------------------------
create table test(id int,name nvarchar(20),quarter int,number int) 
insert into test values(1,N'苹果',1,1000)
insert into test values(1,N'苹果',2,2000)
insert into test values(1,N'苹果',3,4000)
insert into test values(1,N'苹果',4,5000)
insert into test values(2,N'梨子',1,3000)
insert into test values(2,N'梨子',2,3500)
insert into test values(2,N'梨子',3,4200)
insert into test values(2,N'梨子',4,5500)
select * from test
-- ---------行转列---------------------------
select id,name,[Q1] as '一季度',[Q2] as '二季度',[Q3] as '三季度',[Q4] as '四季度' from test pivot(sum(number) for quarter in([Q1],[Q2],[Q3],[Q4])) as pvt
-- ---------列转行---------------------------
create table test(id int,name varchar(20), Q1 int, Q2 int, Q3 int, Q4 int)
insert into test values(1,'苹果',1000,2000,4000,5000)
insert into test values(2,'梨子',3000,3500,4200,5500)
select * from test
-- ---------列转行---------------------------
select id,name,quarter,number from test unpivot(number for quarter in([Q1],[Q2],[Q3],[Q4])) as unpvt
-- ------------------------------------------


-- --删除重复记录
delete from test where id not in (select min(id) from test group by name) -- 重复的name
select name from test group by name having min(number)>=3000 -- 记录number都大于3000的name


-- 优化数据库查询
-- UPDATE STATISTICS testDb.dbo.users
-- 查询待清除的日志
-- SELECT DB_ID('DBNAME'),DB_NAME(1)
DECLARE @minSize int; SET @minsize = 1024 -- 清理日志文件最小1M 
SELECT [file_id],[state_desc] 状态,[size]/1024 AS [大小M],[max_size],[name],[physical_name] FROM sys.database_files WHERE [size]>@minsize
-- SELECT [name],recovery_model_desc FROM sys.databases WHERE recovery_model_desc='FULL'
SELECT database_id, total_log_size_in_bytes [分配], used_log_space_in_bytes [已占用], used_log_space_in_percent [使用率] FROM sys.dm_db_log_space_usage

DECLARE @dbname NVARCHAR(50)
-- --检查日志文件名称[先切换到当前数据库]
SELECT [name], [size] FROM sys.database_files
-- --查看数据库的recovery_model_desc类型
SELECT [name], recovery_model_desc FROM sys.databases WHERE [name]=@dbname AND recovery_model_desc='FULL'
-- --如果是FULL类型，修改为SIMPLE类型

-- --收缩数据库大小
USE [master]
ALTER DATABASE @dbname SET RECOVERY SIMPLE WITH NO_WAIT
ALTER DATABASE @dbname SET RECOVERY SIMPLE
-- --收缩日志文件大小(单位是M)
DBCC SHRINKFILE (@dbname + N'_log' , 10, TRUNCATEONLY)
-- --恢复成FULL类型
USE [master]
ALTER DATABASE AFMS SET RECOVERY FULL WITH NO_WAIT
ALTER DATABASE AFMS SET RECOVERY FULL

-- 备份数据库日志
use [dbName]
declare @bakfile nvarchar(200)
set @bakfile='d:\database_bak\log_bak_'+convert(nvarchar(8),getdate(),112)+'.log'
BACKUP LOG dbName TO DISK = @bakfile WITH RETAINDAYS = 1, COMPRESSION
DBCC SHRINKFILE (N'DBNAME_log', 1, TRUNCATEONLY)



-- --备份数据库SQL
BACKUP DATABASE [dbname] TO DISK=N'/var/opt/mssql/data/dbname.bak' WITH NOFORMAT, INIT, 
 NAME=N'dbname-Full Database Backup', NOSKIP, REWIND, NOUNLOAD, STATS=10, CHECKSUM, CONTINUE_AFTER_ERROR
-- --备份数据库SQL
USE [master]
BACKUP LOG [dbname] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Backup\dbname_LogBackup_2021-04-27_08-35-27.bak' 
	WITH NOFORMAT, NOINIT,  NAME = N'dbname_LogBackup_2021-04-27_08-35-27', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [dbname] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Backup\dbname.bak' 
	WITH  FILE = 1,  MOVE N'dbname_log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Backup\dbname_log.ldf',  NOUNLOAD,  STATS = 5

-- --备份局域网内的数据库-->首先要映射文件访问系统>解决权限问题:关闭防火器(专用网络)
-- -- exec master..xp_cmdshell 'net use \\IP地址\共享目录 "密码" /USER:计算机名\用户名'
exec master..xp_cmdshell 'net use \\192.168.1.114\share "123456789" /USER:192.168.1.114\Administrator'
-- --备份数据库到本机-->请提前创建共享目录share
backup database testDb to disk = '\\192.168.1.114\share\testDb.bak'

-- --删除数据库
ALTER DATABASE EE2WAPXB SET PARTNER OFF; -- 删除镜像
DROP DATABASE EE2WAPXB;

~~~
> `MSSQL Function` 常用函数
~~~sql
-- 查询汉字拼音首字母  SELECT dbo.fn_getPY('你好')
CREATE FUNCTION dbo.fn_getPY(@str nvarchar(4000))
RETURNS nvarchar(4000)
AS
BEGIN
  declare @l int, @r nvarchar(4000)
  declare @t table(c nchar(1) collate Chinese_PRC_CI_AS, r nchar(1))
  insert into @t(c,r)
    select '吖 ', 'A ' union all select '八 ', 'B ' union all
    select '嚓 ', 'C ' union all select '咑 ', 'D ' union all
    select '妸 ', 'E ' union all select '发 ', 'F ' union all
    select '旮 ', 'G ' union all select '铪 ', 'H ' union all
    select '丌 ', 'J ' union all select '咔 ', 'K ' union all
    select '垃 ', 'L ' union all select '嘸 ', 'M ' union all
    select '拏 ', 'N ' union all select '噢 ', 'O ' union all
    select '妑 ', 'P ' union all select '七 ', 'Q ' union all
    select '呥 ', 'R ' union all select '仨 ', 'S ' union all
    select '他 ', 'T ' union all select '屲 ', 'W ' union all
    select '夕 ', 'X ' union all select '丫 ', 'Y ' union all
    select '帀 ', 'Z '
  select @l = len(@str), @r = ' '
  while @l > 0
  begin
    select top 1 @r = r + @r, @l = @l - 1 from @t a where c <= substring(@str,@l,1) order by c desc
    if @@rowcount = 0 select @r = substring(@str, @l, 1) + @r, @l = @l-1
  end
  return(@r)
END

-- 正则替换函数  SELECT dbo.RegexReplace('John Smith', '([a-z]+)\s([a-z]+)', '$2,$1',1)
CREATE FUNCTION dbo.RegexReplace
(
 @string VARCHAR(MAX), -- 被替换的字符串
 @pattern VARCHAR(255), -- 替换模板
 @replaces VARCHAR(255), -- 替换后的字符串
 @IgnoreCase INT = 0 -- 0区分大小写 1不区分大小写
)
RETURNS VARCHAR(8000)
AS
BEGIN
    DECLARE @objRegex INT, @retstr VARCHAR(8000)
    -- 创建对象
    EXEC sp_OACreate 'VBScript.RegExp', @objRegex OUT
    -- 设置属性
    EXEC sp_OASetProperty @objRegex, 'Pattern', @pattern
    EXEC sp_OASetProperty @objRegex, 'IgnoreCase', @IgnoreCase
    EXEC sp_OASetProperty @objRegex, 'Global', 1
    -- 执行
    EXEC sp_OAMethod @objRegex, 'Replace', @retstr OUT, @string, @replaces
    -- 释放
    EXECUTE sp_OADestroy @objRegex
    RETURN @retstr
END

-- 保证正常运行的话，需要将Ole Automation Procedures选项置为1
EXEC sp_configure 'show advanced options', 1
RECONFIGURE WITH OVERRIDE
EXEC sp_configure 'Ole Automation Procedures', 1
RECONFIGURE WITH OVERRIDE

-- 拆分字符串: select * from dbo.fn_split('1,2,3,4',',')
CREATE FUNCTION [dbo].[fn_split] (
	@string        VARCHAR(MAX),
	@separator     VARCHAR(10)
)
RETURNS TABLE
AS
RETURN 
(
    SELECT B.id
    FROM   (
               (
                   SELECT [value] = CONVERT(XML, '<v>' + REPLACE(@string, @separator, '</v><v>') + '</v>')
               ) A 
               OUTER APPLY
               (
                   SELECT id = N.v.value('.', 'varchar(100)') FROM   A.[value].nodes('/v') N(v)
               ) B
           )
)

-- 拆分字符串: select * from dbo.fn_split_top('1,2,3,4',',',2,1)
CREATE FUNCTION [dbo].[fn_split_top] (
	@string        VARCHAR(MAX),
	@separator     VARCHAR(10),
	@offset        int,
	@take          int = 1
)
RETURNS TABLE
AS
RETURN 
(
    SELECT B.id
    FROM   (
               (
                   SELECT [value] = CONVERT(XML, '<v>' + REPLACE(@string, @separator, '</v><v>') + '</v>')
               ) A 
               OUTER APPLY
               (
                   SELECT id = N.v.value('.', 'varchar(100)') FROM   A.[value].nodes('/v') N(v)
               ) B
           )
     ORDER BY B.id offset @offset ROWS FETCH NEXT @take ROWS ONLY
)

-- 拆分字符串: select * from dbo.fn_split2id('1,A;2,B;3,C;4,D',';',',')
CREATE FUNCTION [dbo].[fn_split2id] (
	@ids varchar(max),
	@spl char(1)=';',@spr char(1)=','
)
RETURNS @tbl TABLE (i varchar(100),d varchar(100))
AS
BEGIN
declare @i int
declare @id varchar(100)
set @ids=@ids+@spl
set @i=charindex(@spl,@ids)
while @i<>0
begin
	set @id=substring(@ids,1,@i-1)
	IF @id<>'' INSERT INTO @tbl(i,d) VALUES(substring(@id,1,charindex(@spr,@id)-1),substring(@id,charindex(@spr,@id)+1,len(@id)))
	set @ids=substring(@ids,@i+1,(len(@ids)-@i))
	set @i=charindex(@spl,@ids)
end
RETURN
END

-- 拆分字符串: select * from dbo.fn_split2ids('1,2,3,4','A,B,C,D','Arial,Beel,Core,Do',',')
CREATE FUNCTION [dbo].[fn_split2ids] (
	@ids varchar(max),
	@dds varchar(max),
	@sds varchar(max),
	@spl char(1)=','
)
RETURNS @tbl TABLE (i varchar(100),d varchar(100),s varchar(100))
AS
BEGIN
declare @i int,@d int,@s int
declare @id varchar(100),@dd varchar(100),@sd varchar(100)
set @ids=@ids+@spl;set @dds=@dds+@spl;set @sds=@sds+@spl
set @i=charindex(@spl,@ids);set @d=charindex(@spl,@dds);set @s=charindex(@spl,@sds)
while @i<>0 and @d<>0 and @s<>0
begin
	set @id=substring(@ids,1,@i-1);set @dd=substring(@dds,1,@d-1);set @sd=substring(@sds,1,@s-1)
	IF @id<>'' and @dd<>'' and @sd<>'' INSERT INTO @tbl(i,d,s) VALUES(@id,@dd,@sd)
	set @ids=substring(@ids,@i+1,(len(@ids)-@i));set @dds=substring(@dds,@d+1,(len(@dds)-@d));set @sds=substring(@sds,@s+1,(len(@sds)-@s))
	set @i=charindex(@spl,@ids);set @d=charindex(@spl,@dds);set @s=charindex(@spl,@sds)
end
RETURN
END
GO
-- 日期格式: select dbo.datepartf(datepart(year,getdate()),'',4)+'-'+dbo.datepartf(datepart(month,getdate()),'0',2)+'-'+dbo.datepartf(datepart(day,getdate()),'0',2)
CREATE FUNCTION [dbo].[datepartf] (@Source nvarchar(20),@PaddingChar nchar(1),@TotalWidth tinyint) 
RETURNS nvarchar(20) AS BEGIN DECLARE @Result nvarchar(20) 
SELECT @Result = REPLICATE(@PaddingChar, @TotalWidth - LEN(@Source)) + @Source 
RETURN @Result 
END

-- 日期按周统计: SET DATEFIRST 1; select * from dbo.fn_createWeeklyStatisticsTable('2019-01-01','2019-02-15');
DROP FUNCTION [dbo].[fn_createWeeklyStatisticsTable];
GO
CREATE FUNCTION [dbo].[fn_createWeeklyStatisticsTable] (
	@StartDate CHAR(10), -- 开始时间
	@EndDate CHAR(10) -- 结束时间
)
RETURNS @tbl TABLE ([Id] int NOT NULL IDENTITY(1,1) PRIMARY KEY CLUSTERED, [Y] int NOT NULL DEFAULT ((0)), [M] int NOT NULL DEFAULT ((0)), [D] int NOT NULL DEFAULT ((0)), [DY] int NOT NULL DEFAULT ((0)), [DY2] int NOT NULL DEFAULT ((0)), [WM] int NOT NULL DEFAULT ((0)), [WY] int NOT NULL DEFAULT ((0)), [StartDate] char(10) NOT NULL, [EndDate] char(10) NOT NULL, [State] int NOT NULL DEFAULT ((0)))
AS
BEGIN
--SET DATEFIRST 1 --设置每周的起始天为周一
DECLARE @Y INT=0, @M INT=0, @M2 INT=0, @D INT=0, @D2 INT=0, @DY INT=0, @DY2 INT=0, @WM INT=0, @WM2 INT=0, @WY INT=0, @WY2 INT=0, @tmpM INT=0, @tmpWY INT=0
DECLARE @OneDate datetime = @StartDate
DECLARE @EndWhile datetime = @EndDate
DECLARE @TmpDate CHAR(10) = @StartDate
DECLARE @TmpDate2 CHAR(10) = @StartDate
SET @M=datepart(month,@OneDate)
SET @D=datepart(day,@OneDate)
SET @DY=datepart(dayofyear,@OneDate)
SET @WM=datediff(week,dateadd(week,datediff(week,0,dateadd(month,datediff(month,0,@OneDate),0)),0),@OneDate-1)+1
SET @WY=datepart(week,@OneDate)
WHILE (@OneDate <= @EndWhile)
BEGIN
SET @TmpDate2=CONVERT(CHAR(10),@OneDate,20)
SET @Y=datepart(year,@OneDate) -- Year
SET @M2=datepart(month,@OneDate) -- Month
SET @D2=datepart(day,@OneDate) -- DayOfMonth
SET @DY2=datepart(dayofyear,@OneDate) -- DayOfYear
SET @WM2=datediff(week,dateadd(week,datediff(week,0,dateadd(month,datediff(month,0,@OneDate),0)),0),@OneDate-1)+1 -- WeekOfMonth
IF @WM2=0 SET @M2=@M2-1; IF @M2=0 SET @M2=1;
IF @D>29 AND @WM=5 AND @DY2-@DY<3 BEGIN SET @tmpM=@M2; SET @M=@M+1; SET @WM=1; SET @D=1; END -- Month Repair
SET @WY2=datepart(week,@OneDate) -- WeekOfYear
IF (@tmpM < @M2 OR @WY2 > @tmpWY)
BEGIN
SET @tmpM=@M2
SET @tmpWY=@WY2
IF (@DY <> @DY2)
BEGIN
INSERT INTO @tbl([Y],[M],[D],[DY],[DY2],[WM],[WY],[StartDate],[EndDate],[State])
SELECT @Y,@M,@D,@DY,@DY2,@WM,@WY,@TmpDate,@TmpDate2,0
END
SET @M=@M2
SET @D=@D2
SET @DY=@DY2
SET @WM=@WM2
SET @WY=@WY2
SET @TmpDate=@TmpDate2
END
SET @OneDate=DATEADD(day,1,@OneDate)
END
INSERT INTO @tbl([Y],[M],[D],[DY],[DY2],[WM],[WY],[StartDate],[EndDate],[State])
SELECT @Y,@M,@D,@DY,@DY2,@WM,@WY,@TmpDate,@TmpDate2,0
RETURN
END

~~~


> [`Oracle`](https://www.oracle.com) ~ `sql语句`

~~~sql
PURGE recyclebin;  # oracle10g回收站Recycle清除Purge
~~~


----

### 数据库设计

	下边分为建表规约、SQL规约、索引规约三个部分，每部分的每一条都有强制、建议两个级别，大家在参考时，根据自己公司的情况来权衡。

#### 一、建表规约

	【强制】（1） 存储引擎必须使用InnoDB
	解读：InnoDB支持事物、行级锁、并发性能更好，CPU及内存缓存页优化使得资源利用率更高。

	【强制】（2）每张表必须设置一个主键ID，且这个主键ID使用自增主键（在满足需要的情况下尽量短），除非在分库分表环境下。
	解读：由于InnoDB组织数据的方式决定了需要有一个主键，而且若是这个主键ID是单调递增的可以有效提高插入的性能，避免过多的页分裂、
	减少表碎片提高空间的使用率。而在分库分表环境下，则需要统一来分配各个表中的主键值，从而避免整个逻辑表中主键重复。

	【强制】（3）必须使用utf8mb4字符集
	解读：在Mysql中的UTF-8并非“真正的UTF-8”，而utf8mb4”才是真正的“UTF-8”。

	【强制】（4） 数据库表、表字段必须加入中文注释
	解读：大家都别懒

	【强制】（5） 库名、表名、字段名均小写，下划线风格，不超过32个字符，必须见名知意，禁止拼音英文混用。
	解读：约定

	【强制】（6）单表列数目必须小于30，若超过则应该考虑将表拆分
	解读：单表列数太多使得Mysql服务器处理InnoDB返回数据之间的映射成本太高

	【强制】（7）禁止使用外键，如果有外键完整性约束，需要应用程序控制
	解读：外键会导致表与表之间耦合，UPDATE与DELETE操作都会涉及相关联的表，十分影响SQL的性能，甚至会造成死锁。

	【强制】（8）必须把字段定义为NOT NULL并且提供默认值
	解读：a、NULL的列使索引/索引统计/值比较都更加复杂，对MySQL来说更难优化 b、NULL这种类型Msql内部需要进行特殊处理，
	增加数据库处理记录的复杂性；同等条件下，表中有较多空字段的时候，数据库的处理性能会降低很多 c、NULL值需要更多的存储空，
	无论是表还是索引中每行中的NULL的列都需要额外的空间来标识。

	【强制】（9）禁用保留字，如DESC、RANGE、MARCH等，请参考Mysql官方保留字。
	【强制】（10）如果存储的字符串长度几乎相等，使用CHAR定长字符串类型。
	解读：能够减少空间碎片，节省存储空间。更多SQL技巧可搜索公号：SQL数据库开发

	【建议】（11）在一些场景下，考虑使用TIMESTAMP代替DATETIME。
	解读：a、这两种类型的都能表达"yyyy-MM-dd HH:mm:ss"格式的时间，TIMESTAMP只需要占用4个字节的长度，
	可以存储的范围为(1970-2038)年，在各个时区，所展示的时间是不一样的；
	b、而DATETIME类型占用8个字节，对时区不敏感，可以存储的范围为(1001-9999)年。

	【建议】（12）当心自动生成的Schema，建议所有的Schema手动编写。
	解读：对于一些数据库客户端不要太过信任。


#### 二、SQL规约

	【建议】 (1) 为了充分利用缓存，不允许使用自定义函数、存储函数、用户变量。
	解读：如果查询中包含任何用户自定义函数、存储函数、用户变量、临时表、Mysql库中的系统表，其查询结果都不会被缓存。
	比如函数NOW()或者CURRENT_DATE()会因为不同的查询时间，返回不同的查询结果。

	【强制】（2）在查询中指定所需的列，而不是直接使用“ *”返回所有的列
	解读：a）读取不需要的列会增加CPU、IO、NET消耗 b）不能有效的利用覆盖索引

	【强制】（3）不允许使用属性隐式转换
	解读：假设我们在手机号列上添加了索引，然后执行下面的SQL会发生什么？
	explain SELECT user_name FROM parent WHERE phone=13812345678; 很明显就是索引不生效，会全表扫描。

	【建议】（4）在WHERE条件的属性上使用函数或者表达式
	解读：Mysql无法自动解析这种表达式，无法使用到索引。

	【强制】（5）禁止使用外键与级联，一切外键概念必须在应用层解决。
	解读：外键与级联更新适用于单机低并发，不适合分布式、高并发集群;级联更新是强阻塞，存在数据库更新风暴的风险；
	外键影响数据库的插入速度。

	【建议】（6）应尽量避免在WHERE子句中使用or作为连接条件
	解读：根据情况可以选择使用UNION ALL来代替OR

	【强制】（7）不允许使用%开头的模糊查询
	解读：根据索引的最左前缀原理，%开头的模糊查询无法使用索引，可以使用ES来做检索。


#### 三、索引规约

	【建议】（1）避免在更新比较频繁、区分度不高的列上单独建立索引
	解读：区分度不高的列单独创建索引的优化效果很小，但是较为频繁的更新则会让索引的维护成本更高

	【强制】（2） JOIN的表不允许超过五个。需要JOIN的字段，数据类型必须绝对一致; 多表关联查询时，保证被关联的字段需要有索引。
	解读：太多表的JOIN会让Mysql的优化器更难权衡出一个“最佳”的执行计划（可能性为表数量的阶乘），
	同时要注意关联字段的类型、长度、字符编码等是否一致。

	【强制】（3）在一个联合索引中，若第一列索引区分度等于1，那么则不需要建立联合索引。
	解读：索引通过第一列就能够完全定位的数据，所以联合索引的后边部分是不需要的。

	【强制】（4）建立联合索引时，必须将区分度更高的字段放在左边
	解读：区分度更高的列放在左边，能够在一开始就有效的过滤掉无用数据。提高索引的效率，
	相应我们在Mapper中编写SQL的WHERE条件中有多个条件时，需要先看看当前表是否有现成的联合索引直接使用，
	注意各个条件的顺序尽量和索引的顺序一致。

	【建议】（5）利用覆盖索引来进行查询操作，避免回表
	解读：覆盖查询即是查询只需要通过索引即可拿到所需DATA，而不再需要再次回表查询，所以效率相对很高。
	我们在使用EXPLAIN的结果，extra列会出现："using index"。这里也要强调一下不要使用“SELECT * ”，否则几乎不可能使用到覆盖索引。

	【建议】（6）在较长VARCHAR字段,例如VARCHAR(100)上建立索引时，应指定索引长度，没必要对全字段建立索引，根据实际文本区分度决定索引长度即可。
	解读：索引的长度与区分度是一对矛盾体，一般对字符串类型数据，若长度为20的索引，区分度会高达90%以上，则可以考虑创建长度例为20的索引，
	而非全字段索引。例如可以使用 SELECT COUNT(DISTINCT LEFT(lesson_code, 20)) / COUNT(*) FROM lesson;
	来确定lesson_code字段字符长度为20时文本区分度。

	【建议】（7）如果有ORDER BY的场景，请注意利用索引的有序性。ORDER BY最后的字段是联合索引的一部分，并且放在索引组合顺序的最后，
	避免出现file_sort的情况，影响查询性能。
	解读：1、假设有查询条件为WHERE a=? and b=? ORDER BY c； 存在索引：a_b_c，则此时可以利用索引排序。
	2、反例：在查询条件中包含了范围查询，那么索引有序性无法利用，如:WHERE a>10 ORDER BY b; 索引a_b无法排序。

	【建议】（8）在where中索引的列不能某个表达式的一部分，也不能是函数的参数。
	解读：即是某列上已经添加了索引，但是若此列成为表达式的一部分、或者是函数的参数，Mysql无法将此列单独解析出来，索引也不会生效。

	【建议】（9）我们在where条件中使用范围查询时，索引最多用于一个范围条件，超过一个则后边的不走索引。
	解读：Mysql能够使用多个范围条件里边的最左边的第一个范围查询，但是后边的范围查询则无法使用。

	【建议】（10）在多个表进行外连接时，表之间的关联字段类型必须完全一致
	解读：当两个表进行Join时，字段类型若没有完全一致，则加索引也不会生效，这里的完全一致包括但不限于字段类型、字段长度、字符集、collection等

----



#### ✨积分~ [参考DiscuzX3](http://www.dz7.com.cn/library/database/)



#### ✨字段

    Id                主键/标识
    Name              名称
    Path              路径
    State             状态
    Created           创建时间
    AccessCount       访问次数(累加)       int
    Accessed          访问时间(最近)       time.Time
    LifeSpan          活动寿命(时长)       time.Duration
    KeepAlive         保持活动动作 & Accessed & AccessCount
    KeepAliveTime     保持活动时长
    KeepAliveInterval 保持活动心跳
    MaxDataRetries    最大重试次数
    
    Pid          任务ID; TaskId 多个任务ID用半角逗号分隔11,12; RequestId 请求GUID;
    PidMode      任务模式
    Events       事件列表
    Actions      动作列表
    Filters      过滤列表
    Chains       链子列表
    Elements     元素列表
    Options      选项列表
    StartedAt    开始时间    AboutToStart   关于开始时的动作 triggered Callback
    ExpireAt     过期时间    AboutToExpire  关于过期时的动作 triggered Callback
    EndedAt      结束时间    AboutToEnd     关于结束时的动作 triggered Callback
    FinishedAt   完成时间    AboutToFinish  关于完成时的动作 triggered Callback
    Status       状态信息    AboutToChange  关于变化时的动作 triggered Callback
    Running      正在运行?           bool
    Paused       暂停状态?           bool
    Restarting   重新运行?           bool
    Killed       被杀掉了?           bool
    Dead         已死掉了?           bool
    Error        异常               string
    ExitCode     退出码#             int
    RestartCount 重试次数            int
    Priority     优先级              int    `正常` 0 for normal , `紧急` 1 for emergency
    SecurityOpt  安全属性
    Ulimits      用户限制
    MaskedPaths  遮罩路径
    PrivatePaths 私密路径
    ReadonlyPaths只读路径
    PublicPaths  公开路径
    
    User         用户
    Aliases      别名
    Source       来源
    Destination  目标
    Description  描述
    Mode         模式
    Propagation  传播
    Labels       标签
    Settings     设置
    Gateway      网关
    IPAddress    IP地址
    MacAddress   Mac地址
    EmailAddress 邮箱地址
    
    Throttling   请求被流量控制限制
    IllegalOperation 非法域名，无法操作
    OperationDenied  账号未开通***服务
    OperationDeniedSuspended 账号已欠费，请充值
    InvalidDomainConfigure域名配置失败
    InvalidDomainNotFound 域名不存在或不属于当前用户
    InvalidDomainOffline  域名已下线
    QuotaExceededRefresh  超出当日刷新限制
    ServiceBusy 正在配置中, 请稍后再试
    MissingParameter 缺少***参数
    QuotaPerMinuteExceededRefresh 超出每分钟刷新限制
    InvalidObjectTypeValueNotSupported 不支持指定的值
    InvalidExtensiveDomainValueNotSupported 不支持泛域名
    InvalidObjectPathMalformed ***值格式错误
    
    StartTime    开始时间
    EndTime      结束时间
    PageNumber   返回数据的页码
    PageSize     整页大小
    Total        总条数
    

----



### 数据库.LOGIN.ACCOUNTS.
~~~
sa HGJ766GR767FKJU0  +or  HGJ766GR767FKJU0@
root HGJ766GR767FKJU0
cron HGJ766GR767FKJU0
admin HGJ766GR767FKJU0
postgres HGJ766GR767FKJU0

~~~

### 邮箱.LOGIN.ACCOUNTS.
~~~
angenals@163.com HGJ766GR	smtp.163.com 465 #? http://help.163.com/09/1224/17/5RAJ4LMH00753VB8.html

~~~

### 远程.LOGIN.ACCOUNTS.
~~~
Administrator yzHGJ766GR767FKJU0
centos yzHGJ766GR767FKJU0
ubuntu yzHGJ766GR767FKJU0

~~~

