# *DB*

## 数据库
    简而言之可视为电子化的文件柜——存储电子文件的处所，用户可以对文件中的数据进行新增、截取、更新、删除等操作。
    所谓“数据库”是以一定方式储存在一起、能予多个用户共享、具有尽可能小的冗余度、与应用程序彼此独立的数据集合。

 >  [`数据库设计`](#数据库设计)

## 数据库管理系统
    Database Management System，简称`DBMS`，为管理数据库而设计的电脑软件系统，
    一般具有存储、截取、安全保障、备份等基础功能。  数据库管理系统可以依据它所支持的数据库模型来作分类，例如`关系式`、`XML`；
    或依据所支持的计算机类型来作分类，例如服务器群集、移动电话； 或依据所用查询语言来作分类，例如`SQL`、`XQuery`；
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
- 平面模型（表格模型，一般在形式上是一个二维数组。如表格模型数据Excel)

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


### SQL查询语句

 * DML（data manipulation language）数据操纵语言
    * 对数据库的数据进行一些操作，包括（SELECT、UPDATE、INSERT、DELETE等）
 * DDL（data definition language）数据库定义语言
    * 定义表的结构，数据类型，表之间的链接和约束，包括（CREATE、ALTER、DROP等）
 * DCL（Data Control Language）数据库控制语言
    * 设置数据库用户或角色权限的语句，包括（grant,deny,revoke等）

#### 获取数据 DML-SELECT
~~~sql
## 过滤数据 Filtering Data
SELECT name FROM users WHERE gender = 1 AND (age BETWEEN 20 AND 30) AND country IN ('CHINA','USA')
## 日期时间 Date and Time
 #@ MySQL
SELECT name,DATE_FORMAT(birthday,'%Y-%m-%d') FROM users WHERE YEAR(birthday)=YEAR(now())
 #@ Oracle
SELECT name,to_char(birthday,'YYYY-MM-DD') FROM users WHERE age = 20

## 分页数据 Limiting Results
 #@ MySQL,PostgreSQL,SQLite
SELECT name FROM users LIMIT 5           # 只取前5条
SELECT name FROM users LIMIT 5, 5        # 从第6条取到第10条
 #@ MsSQL, Access
SELECT TOP 5 name FROM users             # 只取前5条
SELECT name FROM users ORDER BY id OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY # 从第6条取到第10条 MsSQL^2012
 #@ DB2
SELECT name FROM users FETCH FIRST 5 ROWS ONLY # 只取前5条
 #@ Oracle
SELECT name FROM users WHERE ROWNUM <= 5 # 只取前5条
 #@ Firebird,Interbase
SELECT name FROM users ROWS 5            # 只取前5条
SELECT name FROM users ROWS 6 TO 10      # 从第6条取到第10条

~~~

----


### 数据库设计


#### 常用字段

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
    
