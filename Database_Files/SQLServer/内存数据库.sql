--内存数据库
/*
改变 bucket 总数: 太高会浪费内存, 太低则损害性能.
	1.创建内存优化表是需要注明 MEMORY_OPTIMIZED=ON, 并设置持久性: SCHEMA_AND_DATA持久化数据和结构, SCHEMA_ONLY只持久化结构
	2.不支持BLOB数据类型
	3.创建表至少有一个索引, 自动为主键约束创建索引, 并指定hash索引的bucket_count
	4.创建表后,数据库引擎会自动加载用于DML的原生编译存储过程,像加载ddl一样
	5.数据库自身不操作内存数据库的数据,而是通过ddl来操作
	6.内存数据库的限制:
		  1.没有触发器 2.没有外键和check 3.没有identity 4.没有主键以外的唯一索引 5.最大8个索引,包括主键索引
		  6.不能通过alter table修改表结构, 索引没有DDL, 索引是和表一体的, 作为表的一部分创建.
*/
--DROP DATABASE Demo
--支持2012以上版本
--ALTER DATABASE Demo SET COMPATIBILITY_LEVEL = 110
/*添加到已有数据库*/
USE master
GO
ALTER DATABASE Demo ADD FILEGROUP DemoHKG1 CONTAINS MEMORY_OPTIMIZED_DATA
GO
ALTER DATABASE Demo ADD FILE --FILENAME是一个目录, 最大Size是512MB
( NAME = N'DemoHKG1', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\DemoHKG1', MAXSIZE = 393216KB ) 
TO FILEGROUP DemoHKG1
GO
USE Demo
--Drop table if it already exists
--简化版---------------------------------------------------------------------------------------
IF OBJECT_ID('HKT','U') IS NOT NULL DROP TABLE HKT
GO -- 内存表
CREATE TABLE HKT
(
	TKey nvarchar(36) PRIMARY KEY NONCLUSTERED HASH WITH (BUCKET_COUNT = 2048),
	TValue nvarchar(1200) NOT NULL,
   INDEX IX_Value NONCLUSTERED (TValue)
) WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA)
--标准版---------------------------------------------------------------------------------------
GO -- 内存表
CREATE TABLE HKT
(
	TKey nvarchar(36) COLLATE Chinese_PRC_CI_AS NOT NULL,
	TValue nvarchar(1200) COLLATE Chinese_PRC_CI_AS NOT NULL,
INDEX IX_Value NONCLUSTERED 
(
	TValue ASC
),
PRIMARY KEY NONCLUSTERED HASH 
(
	TKey
)WITH ( BUCKET_COUNT = 2048)
)WITH ( MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_AND_DATA )
GO -- 普通表
CREATE TABLE LKT(
	TKey nvarchar(36) NOT NULL,
	TValue nvarchar(1200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	TKey ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON PRIMARY
) ON PRIMARY
GO
-----------------------------------------------------------------------------------------------
IF OBJECT_ID('HKT1','U') IS NOT NULL DROP TABLE HKT1
GO
CREATE TABLE HKT1
(
	Id int NOT NULL, 
	Name nvarchar(36) NOT NULL,
	GroupName nvarchar(36) NOT NULL INDEX NC_IX_1 NONCLUSTERED (GroupName), 
   -- +索引 CONSTRAINT PK_HKT1 PRIMARY KEY NONCLUSTERED (Id) HASH WITH (BUCKET_COUNT = 2048)
   CONSTRAINT PK_HKT1 PRIMARY KEY NONCLUSTERED (Id), 
   -- See SQL Server Books Online for guidelines on determining appropriate bucket count for the index
   INDEX IX_MEMORY UNIQUE HASH (Name) WITH (BUCKET_COUNT = 2048)
) WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA)
GO
IF OBJECT_ID('HKT2','U') IS NOT NULL DROP TABLE HKT2
GO
CREATE TABLE HKT2
(
	Id int NOT NULL PRIMARY KEY NONCLUSTERED HASH WITH (BUCKET_COUNT = 2048),
	Title nvarchar(36) NOT NULL INDEX NC_IX_1 NONCLUSTERED (Title),
	Content nvarchar(3600) NOT NULL,
	Created datetime NOT NULL DEFAULT GETDATE(),
	Updated datetime NOT NULL DEFAULT GETDATE()
) WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA)
GO
