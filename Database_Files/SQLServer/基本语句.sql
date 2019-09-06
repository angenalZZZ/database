--版本
SELECT @@VERSION -- Enterprise Edition、Standard Edition、Developer Edition
--支持2012以上版本
-- ALTER DATABASE dbname SET COMPATIBILITY_LEVEL = 110
--内存
-- dbcc memorystatus
--进程列表
SELECT dbid,db_name(dbid) as dbname,* from sys.sysprocesses order by db_name(dbid)
--查看当前的数据库用户连接有多少
DECLARE @dbname varchar(50)='EnterpriseEducation'
SELECT dbid,db_name(dbid) as dbname,* from sys.sysprocesses where dbid=db_id(@dbname)
SELECT @@CPU_BUSY as CPU_BUSY, @@CONNECTIONS as CONNECTIONS, @@TOTAL_READ as TOTAL_READ, @@TOTAL_WRITE as TOTAL_WRITE,
[DB_name]=@dbname,[DB_processes]=(SELECT COUNT(*) FROM sys.sysprocesses WHERE dbid=db_id(@dbname))
--SELECT * FROM sys.dm_exec_sessions WHERE database_id=db_id(@dbname) ORDER BY total_elapsed_time DESC
--SELECT bucketid,sql,sqlbytes,objtype FROM sys.syscacheobjects WHERE dbid=db_id(@dbname) ORDER BY bucketid DESC

--CPU占用高的20条语句(10分钟内) 
SELECT TOP 20 db_name(qp.dbid) [db_name], last_execution_time, 
 (SELECT SUBSTRING(text,statement_start_offset/2+1,(CASE WHEN statement_end_offset=-1 THEN LEN(CONVERT(nvarchar(max),text))*2 
 ELSE statement_end_offset END - statement_start_offset)/2) FROM sys.dm_exec_sql_text(sql_handle)) [sql],
 total_worker_time/execution_count [avg_cpu], total_elapsed_time/execution_count [avg_time], execution_count [count]
FROM sys.dm_exec_query_stats qs CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) as qp WHERE last_execution_time>DATEADD(MINUTE,-10,GETDATE()) ORDER BY [avg_cpu] DESC

--最新执行的20条语句
SELECT TOP 20 db_name(qp.dbid) [db_name], last_execution_time, 
 (SELECT SUBSTRING(text,statement_start_offset/2+1,(CASE WHEN statement_end_offset=-1 THEN LEN(CONVERT(nvarchar(max),text))*2 
 ELSE statement_end_offset END - statement_start_offset)/2) FROM sys.dm_exec_sql_text(sql_handle)) [sql],
 total_worker_time/execution_count [avg_cpu], total_elapsed_time/execution_count [avg_time], execution_count [count]
FROM sys.dm_exec_query_stats qs CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) as qp ORDER BY [last_execution_time] DESC


--数据库表结构
SELECT tbl.name AS [TABLE_NAME], SCHEMA_NAME(tbl.schema_id) AS [TABLE_SCHEMA], CAST(case when tbl.is_ms_shipped=1 then 1 when(select major_id from sys.extended_properties where major_id=tbl.object_id and minor_id=0 and class=1 and name=N'microsoft_database_tools_support') is not null then 1 else 0 end AS bit) AS [IsSystemObject] FROM sys.tables AS tbl ORDER BY tbl.name;
--存储过程结构
SELECT cast(xp.[value] as nvarchar(4000)) 
FROM ::fn_listextendedproperty(NULL,N'Schema',N'dbo',N'Procedure',N'proc_import_to_efi_mall_fei_billapply',NULL,NULL) xp 
WHERE xp.name in (N'MS_Description')


--日期时间-- https://www.aliyun.com/jiaocheng/1399735.html
SELECT CONVERT(varchar(23),getdate(),121) as [完整日期时间], CONVERT(varchar(8),getdate(),112) as [日期] -- 21 or 121 | yyyy-mm-dd hh:mi:ss:mmm(24小时制)
SELECT CONVERT(varchar(19),getdate(),120) as [日期时间], CONVERT(varchar(10),getdate(),20) as [日期]     -- 20 or 120 | yyyy-mm-dd hh:mi:ss(24小时制)
SELECT CONVERT(varchar(10),getdate(),108) as [时间], CONVERT(varchar(14),getdate(),114) as [时间ms]
GO
IF EXISTS(SELECT TOP 1 * FROM sysobjects WHERE id=OBJECT_ID(N'datepartf') AND type='FN') DROP FUNCTION datepartf
GO
CREATE FUNCTION dbo.datepartf(@Source nvarchar(20),@PaddingChar nchar(1),@TotalWidth tinyint) RETURNS nvarchar(20) AS BEGIN DECLARE @Result nvarchar(20) SELECT @Result = REPLICATE(@PaddingChar, @TotalWidth - LEN(@Source)) + @Source RETURN @Result END
GO
SELECT dbo.datepartf(datepart(yyyy, getdate()),'0',4)+'-'
	+dbo.datepartf(datepart(mm, getdate()),'0',2)+'-'
	+dbo.datepartf(datepart(dd, getdate()),'0',2)
GO
SELECT datediff(dd,'2018-12-31',getdate()) as [相差几天]
GO

--加密MD5--
SELECT MD5=(LOWER(SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('MD5','123456')), 3, 32)))
SELECT MD5=(LOWER(SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('MD5','123456789')), 3, 32)))

GO
--游标--
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

GO
--动态sql--
EXEC SP_EXECUTESQL @STMT=N'SELECT * FROM sys.databases WHERE compatibility_level=@level ORDER BY name',@PARMS=N'@level tinyint',@level=110;

GO
--哪个引起了阻塞blk
--exec sp_who active;
--锁住了哪些资源？
--exec sp_lock;
GO
--查看被锁语句--
-- select request_session_id spid,OBJECT_NAME(resource_associated_entity_id) tableName from sys.dm_tran_locks where resource_type='OBJECT'
--查看被锁表--
-- select b.text,a.* from master..SysProcesses a cross apply sys.dm_exec_sql_text(sql_handle) b where db_Name(a.dbID)='FEI_MALL' and a.spId<>@@SpId

--查看锁<锁模式>
--共享 (S) 用于不更改或不更新数据的操作（只读操作），如 SELECT 语句
--更新 (U) 用于可更新的资源中。防止当多个会话在读取、锁定以及随后可能进行的资源更新时发生常见形式的死锁
--排它 (X) 用于数据修改操作，例如 INSERT、UPDATE 或 DELETE。确保不会同时同一资源进行多重更新
--意向锁 用于建立锁的层次结构。意向锁的类型为：意向共享 (IS)、意向排它 (IX) 以及与意向排它共享 (SIX)
--架构锁 在执行依赖于表架构的操作时使用。架构锁的类型为：架构修改 (Sch-M) 和架构稳定性 (Sch-S)
--大容量更新 (BU) 向表中大容量复制数据并指定了 TABLOCK 提示时使用
select str(request_session_id,4,0) as spid,convert(varchar(20),db_name(resource_database_id)) as [db_name],case when resource_database_id = db_id() and resource_type='OBJECT' then convert(char(20), object_name(resource_Associated_Entity_id)) else convert(char(20), resource_Associated_Entity_id) end as [资源],convert(varchar(12), resource_type) as resrc_type,convert(varchar(12), request_type) as req_type,convert(char(3), request_mode) as [锁模式],convert(varchar(8), request_status) as status from sys.dm_tran_locks
where resource_database_id=db_id('EnterpriseEducation') order by request_session_id desc
--看到当前那个表有锁--------------------------------------------------------
select request_session_id sessionid,resource_type type,convert(varchar(20), db_name(resource_database_id)) as [db_name],OBJECT_NAME(resource_associated_entity_id, resource_database_id) tbl_name,request_mode [锁模式],request_status rstatus from sys.dm_tran_locks
where resource_database_id=db_id('EnterpriseEducation') and resource_type='OBJECT' order by request_session_id desc
--解除锁--------------------------------------------------------------------
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

--备份数据库SQL
BACKUP DATABASE [dbname] TO DISK=N'/var/opt/mssql/data/dbname.bak' WITH NOFORMAT, INIT, NAME=N'dbname-Full Database Backup', NOSKIP, REWIND, NOUNLOAD, STATS=10, CHECKSUM, CONTINUE_AFTER_ERROR

--备份局域网内的数据库--/首先要映射文件访问系统/解决权限问题:关闭防火器(专用网络)
-- exec master..xp_cmdshell 'net use \\IP地址\共享目录 "密码" /USER:计算机名\用户名'
exec master..xp_cmdshell 'net use \\192.168.20.114\share "angenal" /USER:192.168.20.114\Administrator'
--备份数据库到本机
backup database EnterpriseEducation to disk = '\\192.168.20.114\share\EnterpriseEducation.bak'


GO
DECLARE @dbname NVARCHAR(50)
--检查日志文件名称[先切换到当前数据库]
SELECT [name], [size] FROM sys.database_files
--查看数据库的recovery_model_desc类型
SELECT [name], recovery_model_desc FROM sys.databases WHERE [name]=@dbname AND recovery_model_desc='FULL'
--如果是FULL类型，修改为SIMPLE类型
GO
USE [master]
GO
ALTER DATABASE @dbname SET RECOVERY SIMPLE WITH NO_WAIT
GO
ALTER DATABASE @dbname SET RECOVERY SIMPLE
--收缩日志文件大小(单位是M)
DBCC SHRINKFILE (@dbname + N'_log' , 10, TRUNCATEONLY)
--恢复成FULL类型
GO
USE [master]
GO
ALTER DATABASE AFMS SET RECOVERY FULL WITH NO_WAIT
GO
ALTER DATABASE AFMS SET RECOVERY FULL
GO

--查看当前的存放位置 
select * from sys.master_files
select database_id,name,physical_name AS CurrentLocation,state_desc,size from sys.master_files
where database_id=db_id(@dbname)

--修改文件的存放位置下次启动生效
--testDb为数据库名，
alter database 数据库名 modify file ( name = 文件名(不包含后缀), filename = '文件存储路径'); 
alter database 数据库名 modify file ( name = 文件名(不包含后缀), filename = '文件存储路径'); 
--eg. 
  alter database testDb modify file ( name = testDb, filename = 'G:\SQL_DATA\testDb\testDb.mdf'); 
  alter database testDb modify file ( name = testDb_log, filename = 'G:\SQL_DATA\testDb\testdb_log.ldf'); 

--修改默认的数据库文件存放位置 即时生效
EXEC xp_instance_regwrite  
@rootkey='HKEY_LOCAL_MACHINE',  
@key='Software\Microsoft\MSSQLServer\MSSQLServer',  
@value_name='DefaultData',  
@type=REG_SZ,  
@value='E:\MSSQL_MDF\data' 
GO
--修改默认的日志文件存放位置 即时生效
EXEC master..xp_instance_regwrite  
@rootkey='HKEY_LOCAL_MACHINE',  
@key='Software\Microsoft\MSSQLServer\MSSQLServer',  
@value_name='DefaultLog',  
@type=REG_SZ,  
@value='E:\MSSQL_MDF\log' 
GO

--查询数据库权限
SELECT DISTINCT class_desc FROM fn_builtin_permissions(default) ORDER BY class_desc;
SELECT * FROM fn_my_permissions(NULL, 'SERVER');
SELECT * FROM fn_my_permissions(NULL, 'DATABASE');
GO

--链接外部服务器
exec sys.sp_addlinkedserver '链接别名','数据库类型','SQLOLEDB','远程服务器名或ip地址' -- 数据库类型为空时-默认:sqlserver
exec sys.sp_addlinkedsrvlogin '链接别名','false',null,'用户名','密码'
--select * from 链接别名.数据库名.dbo.表名
exec sys.sp_droplinkedsrvlogin '数据库名',null
exec sys.sp_dropserver '数据库名'
GO

--合并查询/逗号分隔结果
select (stuff((select ','+a.UserName from HonorUser u inner join UserAccount a on u.UserId=a.Id where u.HonorId='1' for xml path('')),1,1,''))
GO

--字符集
--制表符: CHAR(9)
--换行符: CHAR(10)
--回车符: CHAR(13)
---------行转列---------------------------
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
---------行转列---------------------------
select id,name,[Q1] as '一季度',[Q2] as '二季度',[Q3] as '三季度',[Q4] as '四季度' from test pivot(sum(number) for quarter in([Q1],[Q2],[Q3],[Q4])) as pvt
---------列转行---------------------------
create table test(id int,name varchar(20), Q1 int, Q2 int, Q3 int, Q4 int)
insert into test values(1,'苹果',1000,2000,4000,5000)
insert into test values(2,'梨子',3000,3500,4200,5500)
select * from test
---------列转行---------------------------
select id,name,quarter,number from test unpivot(number for quarter in([Q1],[Q2],[Q3],[Q4])) as unpvt
------------------------------------------
GO
