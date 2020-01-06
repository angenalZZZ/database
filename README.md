# 数据库
    简而言之可视为电子化的文件柜——存储电子文件的处所，用户可以对文件中的数据进行新增、截取、更新、删除等操作。
    所谓“数据库”是以一定方式储存在一起、能予多个用户共享、具有尽可能小的冗余度、与应用程序彼此独立的数据集合。

 > [`✨Sql查询语句`](#sql查询语句)、[`✨数据库设计`](#数据库设计)

## 数据库管理系统
    Database Management System，简称`DBMS`，为管理数据库而设计的电脑软件系统，
    一般具有存储、截取、安全保障、备份等基础功能。  数据库管理系统可以依据它所支持的数据库模型来作分类，例如`关系式`、`XML`
    或依据所支持的计算机类型来作分类，例如服务器群集、移动电话； 或依据所用查询语言来作分类，例如`SQL`、`XQuery`
    或依据性能冲量重点来作分类，例如最大规模、最高运行速度；亦或其他的分类方式。
    不论使用哪种分类方式，一些`DBMS`能够跨类别，例如，同时支持多种查询语言。

## 数据库类型

#### 关系数据库

- MySQL https://www.mysql.com

  - MySQL Enterprise Edition 提供了可扩展性、安全性、可靠性；降低了开发部署和管理的风险、成本和复杂性。
  - MariaDB（MySQL的代替品）https://github.com/MariaDB/server
  - Percona Server（MySQL的代替品）https://github.com/percona/percona-server

- PostgreSQL 世界上最先进的开源关系数据库 https://www.postgresql.org

- Oracle 甲骨文公司软件产品 https://www.oracle.com

- Microsoft SQL Server 微软推出的关系型数据库管理系统 https://www.microsoft.com/zh-cn/sql-server

 几乎所有的数据库管理系统都配备了一个开放式数据库连接（ODBC）驱动程序，令各个数据库之间得以互相集成。

#### 非关系型数据库（NoSQL）

- BigTable（Google）分布式数据存储系统，可扩展到PB级数据和上千台服务器 https://cloud.google.com/bigtable
- MongoDB 基于分布式文件存储的数据库 https://www.mongodb.org.cn
- CouchDB 下一代Web应用存储系统 http://couchdb.apache.org

#### 内存数据库 | 键值（key-value）数据库

- Redis
- LevelDB（Google）

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
    例如车牌、身份证字号、条码等，都是一个索引的号码，当我们看到号码时，可以从号码中看出其中的端倪，若是要找的人、车或物品，
    也只要提供相关的号码，即可迅速查到正确的人事物。

    另外，索引跟字段有着相应的关系，索引即是由字段而来，其中字段有所谓的关键字段（Key Field），该字段具有唯一性，
    即其值不可重复，且不可为`空值null`。例如：在合并数据时，索引便是扮演欲附加字段数据之指向性用途的角色。
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


#### SQL查询语句

 * DDL（data definition language）数据库定义语言
    * 定义表的结构，数据类型，表之间的链接和约束，包括（CREATE、ALTER、DROP等）
 * DCL（Data Control Language）数据库控制语言
    * 设置数据库用户或角色权限的语句，包括（grant,deny,revoke等）
 * DML（data manipulation language）数据操纵语言
    * 对数据库的数据进行一些操作，包括（SELECT、UPDATE、INSERT、DELETE等）
    * `获取数据` 
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

 -- SQLServer 窗口函数 即 OLAP 实时分析处理函数(online analytical processing)
 -- :聚合函数sum,avg,count,max.. :专用函数<row_number,rank..> over([partition by <列清单>] order by <列清单>)
SELECT name, row_number() over (order by score desc) FROM scores -- `row_number`可用于分页但效率一般!
SELECT name, ntile(3) over (order by score desc) FROM scores -- `ntile`排序后进行评分[分区n=3表示上中下3组]
SELECT name, rank() over (partition by name order by income desc) FROM users -- `rank`跳跃排名:1,2,2,4
SELECT name, dense_rank() over (partition by name order by income desc) FROM users -- `dense_rank`连续排名1,2,2,3
SELECT pid,name, avg(price) over (order by pid rows 2 preceding) FROM products -- 截至2之前两行求平均
SELECT pid,name, avg(price) over (order by pid rows 2 following) FROM products -- 截至2之后汇总再求平均
SELECT pid,name, avg(price) over (order by pid rows between 100 preceding and 60 following) FROM products -- 60~100
SELECT type, sum(income) as income_sum from products group by rollup(type) -- 同时得到合计和小计
SELECT grouping(type),grouping(year), sum(income) from products group by rollup(type,year) -- 当null时自动转0
SELECT type,year, sum(income) from products group by cube(type,year) -- 搭积木(把所有可能的组合)汇总到一个结果中

 -- MySQL 使用DECODE函数来减少处理时间(避免重复扫描相同的表或记录)
SELECT COUNT(DECODE(type,'1',1,NULL)) typeCount1, COUNT(DECODE(type,'2',1,NULL)) typeCount2, 
       AVG(DECODE(type,'1',price,NULL)) priceAvg1, AVG(DECODE(type,'2',price,NULL)) priceAvg2 
FROM products 

~~~

> [`Oracle`](https://www.oracle.com) ~ `sql语句`

~~~sql
PURGE recyclebin;  # oracle10g回收站Recycle清除Purge
~~~

> [`SQLServer`](https://www.microsoft.com/zh-cn/sql-server) ~ `sql语句`
 * 优化查询语句的方法
 	* 用exists替代distinct; 用exists替代in; 用not exists替代not in 
	* 用表连接join替换exists 
	* 用索引index提高效率; 避免在索引列上使用`函数`、`IS NULL`等计算 

~~~sql
-- SQLServer版本
SELECT @@VERSION -- Enterprise Edition、Standard Edition、Developer Edition
-- --支持2012以上版本
-- -- ALTER DATABASE dbname SET COMPATIBILITY_LEVEL = 110
-- --内存
-- -- dbcc memorystatus
-- --进程列表
SELECT dbid,db_name(dbid) as dbname,* from sys.sysprocesses order by db_name(dbid)
-- --查看当前的数据库用户连接有多少
DECLARE @dbname varchar(50)='testDb'
SELECT dbid,db_name(dbid) as dbname,* from sys.sysprocesses where dbid=db_id(@dbname)
SELECT @@CPU_BUSY as CPU_BUSY, @@CONNECTIONS as CONNECTIONS, @@TOTAL_READ as TOTAL_READ, @@TOTAL_WRITE as TOTAL_WRITE,
[DB_name]=@dbname,[DB_processes]=(SELECT COUNT(*) FROM sys.sysprocesses WHERE dbid=db_id(@dbname))
-- --SELECT * FROM sys.dm_exec_sessions WHERE database_id=db_id(@dbname) ORDER BY total_elapsed_time DESC
-- --SELECT bucketid,sql,sqlbytes,objtype FROM sys.syscacheobjects WHERE dbid=db_id(@dbname) ORDER BY bucketid DESC

-- --CPU占用高的20条语句(10分钟内) 
SELECT TOP 20 db_name(qp.dbid) [db_name], last_execution_time, 
 (SELECT SUBSTRING(text,statement_start_offset/2+1,(CASE WHEN statement_end_offset=-1 THEN LEN(CONVERT(nvarchar(max),text))*2 
 ELSE statement_end_offset END - statement_start_offset)/2) FROM sys.dm_exec_sql_text(sql_handle)) [sql],
 total_worker_time/execution_count [avg_cpu], total_elapsed_time/execution_count [avg_time], execution_count [count]
FROM sys.dm_exec_query_stats qs CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) as qp WHERE last_execution_time>DATEADD(MINUTE,-10,GETDATE()) ORDER BY [avg_cpu] DESC

-- --最新执行的20条语句
SELECT TOP 20 db_name(qp.dbid) [db_name], last_execution_time, 
 (SELECT SUBSTRING(text,statement_start_offset/2+1,(CASE WHEN statement_end_offset=-1 THEN LEN(CONVERT(nvarchar(max),text))*2 
 ELSE statement_end_offset END - statement_start_offset)/2) FROM sys.dm_exec_sql_text(sql_handle)) [sql],
 total_worker_time/execution_count [avg_cpu], total_elapsed_time/execution_count [avg_time], execution_count [count]
FROM sys.dm_exec_query_stats qs CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) as qp ORDER BY [last_execution_time] DESC


-- --数据库表结构
SELECT tbl.name AS [TABLE_NAME], SCHEMA_NAME(tbl.schema_id) AS [TABLE_SCHEMA], CAST(case when tbl.is_ms_shipped=1 then 1 when(select major_id from sys.extended_properties where major_id=tbl.object_id and minor_id=0 and class=1 and name=N'microsoft_database_tools_support') is not null then 1 else 0 end AS bit) AS [IsSystemObject] FROM sys.tables AS tbl ORDER BY tbl.name;
-- --存储过程结构
SELECT cast(xp.[value] as nvarchar(4000)) 
FROM ::fn_listextendedproperty(NULL,N'Schema',N'dbo',N'Procedure',N'proc_import_to_efi_mall_fei_billapply',NULL,NULL) xp 
WHERE xp.name in (N'MS_Description')


-- --日期时间-- https://www.aliyun.com/jiaocheng/1399735.html
SELECT CONVERT(varchar(23),getdate(),121) as [完整日期时间], CONVERT(varchar(8),getdate(),112) as [日期] -- 21 or 121 | yyyy-mm-dd hh:mi:ss:mmm(24小时制)
SELECT CONVERT(varchar(19),getdate(),120) as [日期时间], CONVERT(varchar(10),getdate(),20) as [日期]     -- 20 or 120 | yyyy-mm-dd hh:mi:ss(24小时制)
SELECT CONVERT(varchar(10),getdate(),108) as [时间], CONVERT(varchar(14),getdate(),114) as [时间ms]

IF EXISTS(SELECT TOP 1 * FROM sysobjects WHERE id=OBJECT_ID(N'datepartf') AND type='FN') DROP FUNCTION datepartf

CREATE FUNCTION dbo.datepartf(@Source nvarchar(20),@PaddingChar nchar(1),@TotalWidth tinyint) RETURNS nvarchar(20) AS BEGIN DECLARE @Result nvarchar(20) SELECT @Result = REPLICATE(@PaddingChar, @TotalWidth - LEN(@Source)) + @Source RETURN @Result END

SELECT dbo.datepartf(datepart(yyyy, getdate()),'0',4)+'-'
	+dbo.datepartf(datepart(mm, getdate()),'0',2)+'-'
	+dbo.datepartf(datepart(dd, getdate()),'0',2)

SELECT datediff(dd,'2018-12-31',getdate()) as [相差几天]


-- --加密MD5--
SELECT MD5=(LOWER(SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('MD5','123456')), 3, 32)))
SELECT MD5=(LOWER(SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('MD5','123456789')), 3, 32)))
-- --随机字符--
SELECT CAST(CAST(CRYPT_GEN_RANDOM(16) AS UNIQUEIDENTIFIER) AS CHAR(36)) UUID_32;
SELECT UPPER(sys.fn_varbintohexsubstring(0,CRYPT_GEN_RANDOM(16),1,12)) UUID_24;
SELECT UPPER(RIGHT(CAST(sys.fn_varbintohexstr(CRYPT_GEN_RANDOM(10)) AS VARCHAR(36)),16)) UUID_16;
-- --随机整数--
SELECT ABS(CONVERT(bigint,CRYPT_GEN_RANDOM(16))), ABS(CONVERT(bigint,CONVERT(varbinary,CRYPT_GEN_RANDOM(16),1)));



-- --游标--
declare @id int
declare cursor1 cursor for
SELECT [id] FROM [TABLE_NAME]

open cursor1
fetch next from cursor1 into @id
while @@fetch_status=0
BEGIN
	--------------------------------
	fetch next from cursor1 into @id
END
close cursor1
deallocate cursor1


-- --动态sql--
EXEC SP_EXECUTESQL @STMT=N'SELECT * FROM sys.databases WHERE compatibility_level=@level ORDER BY name',@PARMS=N'@level tinyint',@level=110;


-- --哪个引起了阻塞blk
-- --exec sp_who active;
-- --锁住了哪些资源？
-- --exec sp_lock;

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

-- --备份数据库SQL
BACKUP DATABASE [dbname] TO DISK=N'/var/opt/mssql/data/dbname.bak' WITH NOFORMAT, INIT, NAME=N'dbname-Full Database Backup', NOSKIP, REWIND, NOUNLOAD, STATS=10, CHECKSUM, CONTINUE_AFTER_ERROR

-- --备份局域网内的数据库--/首先要映射文件访问系统/解决权限问题:关闭防火器(专用网络)
-- -- exec master..xp_cmdshell 'net use \\IP地址\共享目录 "密码" /USER:计算机名\用户名'
exec master..xp_cmdshell 'net use \\192.168.20.114\share "angenal" /USER:192.168.20.114\Administrator'
-- --备份数据库到本机
backup database testDb to disk = '\\192.168.20.114\share\testDb.bak'



DECLARE @dbname NVARCHAR(50)
-- --检查日志文件名称[先切换到当前数据库]
SELECT [name], [size] FROM sys.database_files
-- --查看数据库的recovery_model_desc类型
SELECT [name], recovery_model_desc FROM sys.databases WHERE [name]=@dbname AND recovery_model_desc='FULL'
-- --如果是FULL类型，修改为SIMPLE类型

USE [master]

ALTER DATABASE @dbname SET RECOVERY SIMPLE WITH NO_WAIT

ALTER DATABASE @dbname SET RECOVERY SIMPLE
-- --收缩日志文件大小(单位是M)
DBCC SHRINKFILE (@dbname + N'_log' , 10, TRUNCATEONLY)
-- --恢复成FULL类型

USE [master]

ALTER DATABASE AFMS SET RECOVERY FULL WITH NO_WAIT

ALTER DATABASE AFMS SET RECOVERY FULL


-- --查看当前的存放位置 
select * from sys.master_files
select database_id,name,physical_name AS CurrentLocation,state_desc,size from sys.master_files
where database_id=db_id(@dbname)

-- --修改文件的存放位置下次启动生效
-- --testDb为数据库名，
alter database 数据库名 modify file ( name = 文件名(不包含后缀), filename = '文件存储路径'); 
alter database 数据库名 modify file ( name = 文件名(不包含后缀), filename = '文件存储路径'); 
-- --eg. 
  alter database testDb modify file ( name = testDb, filename = 'G:\SQL_DATA\testDb\testDb.mdf'); 
  alter database testDb modify file ( name = testDb_log, filename = 'G:\SQL_DATA\testDb\testdb_log.ldf'); 

-- --修改默认的数据库文件存放位置 即时生效
EXEC xp_instance_regwrite  
@rootkey='HKEY_LOCAL_MACHINE',  
@key='Software\Microsoft\MSSQLServer\MSSQLServer',  
@value_name='DefaultData',  
@type=REG_SZ,  
@value='E:\MSSQL_MDF\data' 

-- --修改默认的日志文件存放位置 即时生效
EXEC master..xp_instance_regwrite  
@rootkey='HKEY_LOCAL_MACHINE',  
@key='Software\Microsoft\MSSQLServer\MSSQLServer',  
@value_name='DefaultLog',  
@type=REG_SZ,  
@value='E:\MSSQL_MDF\log' 


-- --查询数据库权限
SELECT DISTINCT class_desc FROM fn_builtin_permissions(default) ORDER BY class_desc;
SELECT * FROM fn_my_permissions(NULL, 'SERVER');
SELECT * FROM fn_my_permissions(NULL, 'DATABASE');


-- --链接外部服务器
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
delete from test where id not in (select min(id) from test group by name); -- 重复的name
select name from test group by name having min(number)>=3000; -- 记录number都大于3000的name


--CPU占用高的20条语句(60分钟内) 
SELECT TOP 20 db_name(qp.dbid) [db_name], last_execution_time, 
 (SELECT SUBSTRING(text,statement_start_offset/2+1,(CASE WHEN statement_end_offset=-1 THEN LEN(CONVERT(nvarchar(max),text))*2 
 ELSE statement_end_offset END - statement_start_offset)/2) FROM sys.dm_exec_sql_text(sql_handle)) [sql],
 total_worker_time/execution_count [avg_cpu], total_elapsed_time/execution_count [avg_time], execution_count [count]
FROM sys.dm_exec_query_stats qs CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) as qp 
WHERE 'testDb'=db_name(qp.dbid) and last_execution_time>DATEADD(MINUTE,-60,GETDATE()) 
ORDER BY [avg_cpu] DESC

SELECT TOP 100 * FROM (SELECT last_execution_time, 
 (SELECT SUBSTRING(text,statement_start_offset/2+1,(CASE WHEN statement_end_offset=-1 THEN LEN(CONVERT(nvarchar(max),text))*2 
 ELSE statement_end_offset END - statement_start_offset)/2) FROM sys.dm_exec_sql_text(sql_handle)) [sql],
 total_worker_time/execution_count [avg_cpu], total_elapsed_time/execution_count [avg_time], execution_count [count]
FROM sys.dm_exec_query_stats WHERE last_execution_time>DATEADD(MINUTE,-100,GETDATE())
)t where [sql] like '%Sys_Account%'
ORDER BY [last_execution_time] DESC

-- 优化数据库
-- UPDATE STATISTICS testDb.dbo.users
-- 查询清除的日志
-- SELECT DB_ID('DBNAME'),DB_NAME(1)
DECLARE @minSize int; SET @minsize = 1024 -- 清理日志文件最小1M 
SELECT [file_id],[state_desc] 状态,[size]/1024 AS [大小M],[max_size],[name],[physical_name] FROM sys.database_files WHERE [size]>@minsize
-- SELECT [name],recovery_model_desc FROM sys.databases WHERE recovery_model_desc='FULL'
SELECT database_id, total_log_size_in_bytes [分配], used_log_space_in_bytes [已占用], used_log_space_in_percent [使用率] FROM sys.dm_db_log_space_usage

USE [master]

ALTER DATABASE DBNAME SET RECOVERY SIMPLE WITH NO_WAIT

ALTER DATABASE DBNAME SET RECOVERY SIMPLE

USE [DBNAME]

--收缩日志文件大小(单位是M)
DBCC SHRINKFILE (N'DBNAME_log' , 1, TRUNCATEONLY)
--恢复成FULL类型

USE [master]

ALTER DATABASE DBNAME SET RECOVERY FULL WITH NO_WAIT

ALTER DATABASE DBNAME SET RECOVERY FULL

-- 备份
use dbName
declare @bakfile nvarchar(200)
set @bakfile='d:\database_bak\log_bak_'+convert(nvarchar(8),getdate(),112)+'.log'
BACKUP LOG dbName TO DISK = @bakfile WITH RETAINDAYS = 1, COMPRESSION
DBCC SHRINKFILE (N'DBNAME_log', 1, TRUNCATEONLY)

~~~

----

### 数据库设计


#### ✨积分~ [参考DiscuzX3](http://www.dz7.com.cn/library/database/)



#### ✨其它常用字段

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
    
