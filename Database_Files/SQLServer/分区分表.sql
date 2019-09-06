-- https://www.sqlshack.com/database-table-partitioning-sql-server
-- https://blog.csdn.net/ExceptionalBoy/article/details/78851327
-- https://www.cnblogs.com/libingql/p/4087598.html
USE master;
GO
IF DB_ID(N'DemoPartition') IS NOT NULL DROP DATABASE DemoPartition;
GO
--数据库保存默认路径: select top 1 REVERSE(SUBSTRING(REVERSE(physical_name),CHARINDEX('\',REVERSE(physical_name)),LEN(physical_name))) from sys.master_files where database_id=db_id('master')
CREATE DATABASE [DemoPartition]
 ON PRIMARY
( NAME = N'DemoPartition', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\DemoPartition.mdf' , SIZE = 8192KB, FILEGROWTH = 65536KB ), 
 FILEGROUP [DemoPartitionG1] 
( NAME = N'DemoPartitionG1F2019', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\DemoPartitionG1F2019.ndf' , SIZE = 8192KB, FILEGROWTH = 65536KB ),
( NAME = N'DemoPartitionG1F2020', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\DemoPartitionG1F2020.ndf' , SIZE = 8192KB, FILEGROWTH = 65536KB ), 
 FILEGROUP [DemoPartitionG2] 
( NAME = N'DemoPartitionG2F2019', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\DemoPartitionG2F2019.ndf' , SIZE = 8192KB, FILEGROWTH = 65536KB ),
( NAME = N'DemoPartitionG2F2020', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\DemoPartitionG2F2020.ndf' , SIZE = 8192KB, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DemoPartition_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\DemoPartition_log.ldf' , SIZE = 8192KB, FILEGROWTH = 65536KB )
--查看文件组
--SELECT * FROM sys.filegroups WHERE type = 'FG'
--添加文件组
--ALTER DATABASE DemoPartition
--ADD FILEGROUP DemoPartitionG2
--ALTER DATABASE DemoPartition
--ADD FILE 
--( NAME = N'DemoPartitionG2F2021', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\DemoPartitionG2F2021.ndf' , SIZE = 8192KB, MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
--TO FILEGROUP DemoPartitionG2
GO
/****** 数据库兼容(版本2008: 100, 版本2012: 110) ******/
ALTER DATABASE [DemoPartition] SET COMPATIBILITY_LEVEL = 110
GO
USE DemoPartition;
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [DemoPartition] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO
/****** 分区函数 ******/
CREATE PARTITION FUNCTION [DemoPartitionOfYears](datetime2(0)) AS RANGE RIGHT FOR VALUES (N'2019-01-01T00:00:00.000', N'2020-01-01T00:00:00.000')
--CREATE PARTITION FUNCTION [PartitioningByMonth] (datetime) AS RANGE RIGHT FOR VALUES ('20140201','20140301','20140401','20140501','20140601','20140701','20140801','20140901','20141001','20141101','20141201')
--SELECT * FROM sys.partition_functions
GO
/****** 分区架构 ******/
CREATE PARTITION SCHEME [DemoPartitionOfScheme1] AS PARTITION [DemoPartitionOfYears] TO ([PRIMARY], [DemoPartitionG1], [DemoPartitionG2])
--CREATE PARTITION SCHEME PartitionByMonth AS PARTITION PartitioningByMonth TO (January, February, March, April, May, June, July, Avgust, September, October, November, December)
GO
--SELECT * FROM sys.partition_schemes
GO
--分区表 : 不能再创建主键或聚集索引CLUSTERED,因为聚集索引可以将记录在物理上顺序存储,而分区表是将数据存储在不同的表中,这两个概念是冲突的.
CREATE TABLE [Account] (
	[Id] varchar(36) NOT NULL,
	[AccountName] varchar(36) NOT NULL, 
	[AccountPwd] varchar(36) NOT NULL, 
	[RoleId] varchar(36), 
	[Status] smallint NOT NULL, 
	[PhoneNumber] varchar(36), 
	[RealName] nvarchar(36), 
	[Sex] varchar(1), 
	[Email] varchar(50), 
	[QQ] varchar(36), 
	[WeChat] varchar(36), 
	[HeadImage] varchar(200), 
	[Remark] nvarchar(200), 
	[EnabledMark] bit, 
	[CreateTime] datetime2(0) NOT NULL, 
	[CreateUser] varchar(36) NOT NULL, 
	[DeleteMark] bit NOT NULL, 
	[DeleteTime] datetime2(0), 
	[DeleteUser] varchar(36)
) ON DemoPartitionOfScheme1([CreateTime]);
--CREATE TABLE Reports(ReportDate datetime PRIMARY KEY, MonthlyReport varchar(256)) ON PartitionByMonth (ReportDate)
--查询分区表中的记录,在各分区文件上的记录数.
--SELECT p.partition_number AS PartitionNumber,f.name AS PartitionFilegroup,p.rows AS NumberOfRows FROM sys.partitions p
--JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
--JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
--WHERE OBJECT_NAME(OBJECT_ID) = 'Reports'
GO
/****** 唯一索引 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Account_Id] ON [dbo].[Account]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** 唯一索引 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Account_Name] ON [dbo].[Account]
(
	[AccountName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** 非聚集索引,压缩模式会被置为None ******/
CREATE NONCLUSTERED INDEX [NCIX_Account_Scheme1] ON [dbo].[Account]
(
	[CreateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DemoPartitionOfScheme1]([CreateTime])
GO
/*
* 手动分区函数: exec dbo.DemoPartitionAddFileGroupForNextYear
*/
CREATE PROCEDURE dbo.DemoPartitionAddFileGroupForNextYear AS
BEGIN
DECLARE @addsql nvarchar(1000), @dbname nvarchar(50)=N'DemoPartition'
DECLARE @nextyear nchar(4)=CONVERT(nchar(4),DATEADD(yy,DATEDIFF(yy,0,(DATEADD(yy,1,GETDATE()))),0),120)
DECLARE @filename nvarchar(100)=@dbname+N'G1F'+@nextyear, @filepath nvarchar(100)
SET @filepath=(select top 1 REVERSE(SUBSTRING(REVERSE(physical_name),CHARINDEX('\',REVERSE(physical_name)),LEN(physical_name))) from sys.master_files where database_id=db_id(@dbname))
SET @addsql=N'ALTER DATABASE '+@dbname+N' ADD FILE
( NAME = '''+@filename+N''',
  FILENAME = '''+@filepath+@filename+N'.ndf'',
  SIZE = 8192KB,
  MAXSIZE = 512MB,
  FILEGROWTH = 65536KB )
TO FILEGROUP '+@dbname+N'G1;
ALTER PARTITION SCHEME DemoPartitionOfScheme1 NEXT USED '++@dbname+N'G1'
IF NOT EXISTS(select 1 from sys.master_files where database_id=db_id(@dbname) and name=@filename and type=0)
BEGIN
	EXECUTE sp_executesql @addsql
	IF NOT EXISTS(SELECT 1 FROM sys.partition_range_values a RIGHT JOIN sys.partition_functions b ON b.function_id=a.function_id 
	WHERE b.name='DemoPartitionOfYears' AND CONVERT(varchar(20),[value]) like '%'+@nextyear+'%')
		ALTER PARTITION FUNCTION DemoPartitionOfYears() SPLIT RANGE (@nextyear+N'-01-01T00:00:00.000')
END
END
GO
/*
* 查看分区信息
*/
SELECT [value] AS [分区信息] FROM sys.partition_range_values a RIGHT JOIN sys.partition_functions b ON b.function_id=a.function_id 
WHERE b.name='DemoPartitionOfYears'
--AND boundary_id = 1 --当前分区
