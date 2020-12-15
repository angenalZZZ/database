# [SQLite](https://www.sqlite.org/lang_datefunc.html)

SQLite是嵌入式关系数据库管理系统。 它是独立的，无服务器的，零配置和事务性SQL数据库引擎。

    SQLite是一款轻型的数据库，是遵守ACID的关系型数据库管理系统，它包含在一个相对小的C库中。
    它是D.RichardHipp建立的公有领域项目。它的设计目标是嵌入式的，而且已经在很多嵌入式产品中使用了它，
    它占用资源非常的低，在嵌入式设备中，可能只需要几百K的内存就够了。它能够支持Windows/Linux/Unix等主流的操作系统，
    同时能够跟很多程序语言相结合，比如 Tcl、C#、PHP、Java等，还有ODBC接口，
    同样比起Mysql、PostgreSQL这两款开源的世界著名数据库管理系统来讲，它的处理速度比他们都快。

SQLite功能特性

    1. ACID事务
    2. 零配置 – 无需安装和管理配置
    3. 储存在单一磁盘文件中的一个完整的数据库
    4. 数据库文件可以在不同字节顺序的机器间自由的共享
    5. 支持数据库大小至2TB
    6. 足够小, 大致13万行C代码, 4.43M
    7. 比一些流行的数据库在大部分普通数据库操作要快
    8. 简单, 轻松的API
    9. 包含TCL绑定, 同时通过Wrapper支持其他语言的绑定
    10. 良好注释的源代码, 并且有着90%以上的测试覆盖率
    11. 独立: 没有额外依赖
    12. 源码完全的开源, 你可以用于任何用途, 包括出售它
    13. 支持多种开发语言，C, C++, C#, Go, Java, PHP, Python, Perl, Ruby等

[﻿命令行](https://www.sqlite.org/json1.html)
~~~cmd
> cd A:\database\sqlite && md data
> sqlite3 -list
> create table logs(data json);
> insert into logs values(json_object("name", "foo1", "value", "ber1"));
> insert into logs values(json('{"name": "foo2", "value": "ber2"}'));
> select * from logs;
> select json_extract(data,"$.name") as name from logs;
> .save 'data/json.db'
> .quit
~~~

﻿查询语句

> 检查Table是否存在?
~~~sql
select 1 from sqlite_master WHERE type='table' and name='logtest';
~~~
> 创建Table
~~~sql
# Version 3.3+ 支持 CREATE TABLE IF NOT EXISTS [TableName]; DROP TABLE IF EXISTS [TableName]
CREATE TABLE IF NOT EXISTS [logtest] (
	[Id] integer NOT NULL PRIMARY KEY AUTOINCREMENT, 
	[Code] varchar(50) NOT NULL, 
	[Type] int NOT NULL, 
	[Message] nvarchar(2000) NOT NULL, 
	[Account] varchar(36), 
	[CreateTime] datetime NOT NULL, 
	[CreateUser] varchar(36)
);
~~~
> 查询Table
~~~sql
select * from logs limit 10 offset 0;
~~~


----
