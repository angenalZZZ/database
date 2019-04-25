# *database*

## 简介
    数据库，简而言之可视为电子化的文件柜——存储电子文件的处所，用户可以对文件中的数据进行新增、截取、更新、删除等操作。
    所谓“数据库”是以一定方式储存在一起、能予多个用户共享、具有尽可能小的冗余度、与应用程序彼此独立的数据集合。

  [`数据库设计`](#数据库设计)

## 数据库管理系统
    数据库管理系统（英语：Database Management System，简称DBMS）是为管理数据库而设计的电脑软件系统，
    一般具有存储、截取、安全保障、备份等基础功能。  数据库管理系统可以依据它所支持的数据库模型来作分类，例如关系式、XML；
    或依据所支持的计算机类型来作分类，例如服务器群集、移动电话； 或依据所用查询语言来作分类，例如SQL、XQuery；
    或依据性能冲量重点来作分类，例如最大规模、最高运行速度；亦或其他的分类方式。
    不论使用哪种分类方式，一些DBMS能够跨类别，例如，同时支持多种查询语言。

## 类型

### 关系数据库

- MySQL

- - MariaDB（MySQL的代替品，英文维基百科从MySQL转向MariaDB）
  - Percona Server（MySQL的代替品·）

- PostgreSQL

- Microsoft Access

- Microsoft SQL Server

- Google Fusion Tables

- FileMaker

- Oracle数据库

- Sybase

- dBASE

- Clipper

- FoxPro

- foshub

几乎所有的数据库管理系统都配备了一个开放式数据库连接（ODBC）驱动程序，令各个数据库之间得以互相集成。

### 非关系型数据库（NoSQL）

主条目：NoSQL

- BigTable（Google）
- Cassandra
- MongoDB
- CouchDB

键值（key-value）数据库

- Apache Cassandra（为Facebook所使用）：高度可扩展
- Dynamo
- LevelDB（Google）![img](http://baike.bdimg.com/img/baike/editor/reference.gif)

## 数据库模型

- 对象模型
- 层次模型（轻量级数据访问协议）
- 网状模型（大型数据储存）
- 关系模型
- 面向对象模型
- 半结构化模型
- 平面模型（表格模型，一般在形式上是一个二维数组。如表格模型数据Excel)

### 架构

数据库的架构可以大致区分为三个概括层次：内层、概念层和外层。

- 内层：最接近实际存储体，亦即有关数据的实际存储方式。
- 外层：最接近用户，即有关个别用户观看数据的方式。
- 概念层：介于两者之间的间接层。

### 数据库索引

数据索引的观念由来已久，像是一本书前面几页都有目录，目录也算是索引的一种，只是它的分类较广，例如车牌、身份证字号、条码等，都是一个索引的号码，当我们看到号码时，可以从号码中看出其中的端倪，若是要找的人、车或物品，也只要提供相关的号码，即可迅速查到正确的人事物。

另外，索引跟字段有着相应的关系，索引即是由字段而来，其中字段有所谓的关键字段（Key Field），该字段具有唯一性，即其值不可重复，且不可为"空值（null）"。例如：在合并数据时，索引便是扮演欲附加字段数据之指向性用途的角色。故此索引为不可重复性且不可为空。

### 数据库操作：事务

事务（transaction）是用户定义的一个数据库操作序列，这些操作要么全做，要么全不做，是一个不可分割的工作单位。 事务的ACID特性：

- 基元性（atomicity）
- 一致性（consistency）
- 隔离性（isolation）
- 持续性（durability）

事务的并发性是指多个事务的并行操作轮流交叉运行，事务的并发可能会访问和存储不正确的数据，破坏交易的隔离性和数据库的一致性。

网状数据模型的数据结构 网状模型 满足下面两个条件的基本层次联系的集合为网状模型。 

1. 允许一个以上的结点无双亲； 2. 一个结点可以有多于一个的双亲。![img](http://baike.bdimg.com/img/baike/editor/reference.gif)

### 数据库设计

#### 字段名

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
    
    Pid          任务ID
    PidMode      任务模式
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
    Mode         模式
    Propagation  传播
    Labels       标签
    Settings     设置
    Gateway      网关
    IPAddress    IP地址
    MacAddress   Mac地址
    EmailAddress 邮箱地址
    
    
    
    
    
