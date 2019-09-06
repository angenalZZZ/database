SELECT database_id, total_log_size_in_bytes [分配], used_log_space_in_bytes [已占用], used_log_space_in_percent [使用率] FROM sys.dm_db_log_space_usage
--查询要清除的日志
--SELECT DB_ID('DBNAME'),DB_NAME(1)
DECLARE @minSize int; SET @minsize = 1024 --清理日志文件最小1M 
SELECT [file_id],[state_desc] 状态,[size]/1024 AS [大小M],[max_size],[name],[physical_name] FROM sys.database_files WHERE [size]>@minsize
--SELECT [name],recovery_model_desc FROM sys.databases WHERE recovery_model_desc='FULL'
------------------------------------------------------------------
GO
USE [master]
GO
ALTER DATABASE DBNAME SET RECOVERY SIMPLE WITH NO_WAIT
GO
ALTER DATABASE DBNAME SET RECOVERY SIMPLE
GO
USE [DBNAME]
GO
--收缩日志文件大小(单位是M)
DBCC SHRINKFILE (N'DBNAME_log' , 1, TRUNCATEONLY)
--恢复成FULL类型
GO
USE [master]
GO
ALTER DATABASE DBNAME SET RECOVERY FULL WITH NO_WAIT
GO
ALTER DATABASE DBNAME SET RECOVERY FULL
GO
--USE [DBNAME]
