/*--比较两个数据库的表结构 存储过程 --*/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[_comparestructure]') AND OBJECTPROPERTY(id, N'IsProcedure')=1)
    DROP PROCEDURE [dbo].[_comparestructure] 
GO
/*--比较两个数据库的表结构--
exec dbo._comparestructure 'DBName1','DBName2' 
*/
CREATE PROC _comparestructure
    @dbname1 VARCHAR(250),--数据库1 
    @dbname2 VARCHAR(250) --数据库2 
AS
    CREATE TABLE #tb1
        (
          表名1 VARCHAR(250),
          字段名 VARCHAR(250),
          序号 INT,
          标识 BIT,
          主键 BIT,
          类型 VARCHAR(250),
          占用字节数 INT,
          长度 INT,
          小数位数 INT,
          允许空 BIT,
          默认值 SQL_VARIANT --,
          --字段说明 SQL_VARIANT
        ) 
 
    CREATE TABLE #tb2
        (
          表名2 VARCHAR(250),
          字段名 VARCHAR(250),
          序号 INT,
          标识 BIT,
          主键 BIT,
          类型 VARCHAR(250),
          占用字节数 INT,
          长度 INT,
          小数位数 INT,
          允许空 BIT,
          默认值 SQL_VARIANT --,
          --字段说明 SQL_VARIANT
        )
 
--得到数据库1的结构 
    EXEC('insert into #tb1 SELECT 
    表名=d.name,字段名=a.name,序号=a.colid, 
    标识=case when a.status=0x80 then 1 else 0 end, 
    主键=case when exists(SELECT 1 FROM '+@dbname1+'..sysobjects where xtype=''PK'' and parent_obj=a.id and name in ( 
    SELECT name FROM '+@dbname1+'..sysindexes WHERE indid in( 
    SELECT indid FROM '+@dbname1+'..sysindexkeys WHERE id = a.id AND colid=a.colid 
    ))) then 1 else 0 end, 
    类型=b.name,占用字节数=a.length,长度=a.prec,小数位数=a.scale,允许空=a.isnullable, 
    默认值=isnull(e.text,'''') 
    FROM '+@dbname1+'..syscolumns a 
    left join '+@dbname1+'..systypes b on a.xtype=b.xusertype 
    inner join '+@dbname1+'..sysobjects d on a.id=d.id  and d.xtype=''U'' and d.name <>''dtproperties'' 
    left join '+@dbname1+'..syscomments e on a.cdefault=e.id  
    order by a.id,a.colorder')

--得到数据库2的结构
    EXEC('insert into #tb2 SELECT 
    表名=d.name,字段名=a.name,序号=a.colid, 
    标识=case when a.status=0x80 then 1 else 0 end, 
    主键=case when exists(SELECT 1 FROM '+@dbname2+'..sysobjects where xtype=''PK'' and parent_obj=a.id and name in ( 
    SELECT name FROM '+@dbname2+'..sysindexes WHERE indid in( 
    SELECT indid FROM '+@dbname2+'..sysindexkeys WHERE id = a.id AND colid=a.colid 
    ))) then 1 else 0 end, 
    类型=b.name,占用字节数=a.length,长度=a.prec,小数位数=a.scale,允许空=a.isnullable, 
    默认值=isnull(e.text,'''') 
    FROM '+@dbname2+'..syscolumns a 
    left join '+@dbname2+'..systypes b on a.xtype=b.xusertype 
    inner join '+@dbname2+'..sysobjects d on a.id=d.id  and d.xtype=''U'' and d.name <>''dtproperties'' 
    left join '+@dbname2+'..syscomments e on a.cdefault=e.id   
    order by a.id,a.colorder')

    SELECT  比较结果 = CASE WHEN a.表名1 IS NULL
                             AND b.序号 = 1 THEN '库1缺少表：' + b.表名2
                        WHEN b.表名2 IS NULL
                             AND a.序号 = 1 THEN '库2缺少表:' + a.表名1
                        WHEN a.字段名 IS NULL
                             AND EXISTS ( SELECT    1
                                          FROM      #tb1
                                          WHERE     表名1 = b.表名2 )
                        THEN '库1 [' + b.表名2 + '] 缺少字段：' + b.字段名
                        WHEN b.字段名 IS NULL
                             AND EXISTS ( SELECT    1
                                          FROM      #tb2
                                          WHERE     表名2 = a.表名1 )
                        THEN '库2 [' + a.表名1 + '] 缺少字段：' + a.字段名
                        WHEN a.标识 <> b.标识 THEN '标识不同'
                        WHEN a.主键 <> b.主键 THEN '主键设置不同'
                        WHEN a.类型 <> b.类型 THEN '字段类型不同'
                        WHEN a.占用字节数 <> b.占用字节数 THEN '占用字节数'
                        WHEN a.长度 <> b.长度 THEN '长度不同'
                        WHEN a.小数位数 <> b.小数位数 THEN '小数位数不同'
                        WHEN a.允许空 <> b.允许空 THEN '是否允许空不同'
                        WHEN a.默认值 <> b.默认值 THEN '默认值不同'
                        --WHEN a.字段说明 <> b.字段说明 THEN '字段说明不同'
                        ELSE ''
                   END,
            *
    FROM    #tb1 a FULL JOIN #tb2 b ON a.表名1 = b.表名2 AND a.字段名 = b.字段名
    WHERE   a.表名1 IS NULL
            OR a.字段名 IS NULL
            OR b.表名2 IS NULL
            OR b.字段名 IS NULL
            OR a.标识 <> b.标识
            OR a.主键 <> b.主键
            OR a.类型 <> b.类型
            OR a.占用字节数 <> b.占用字节数
            OR a.长度 <> b.长度
            OR a.小数位数 <> b.小数位数
            OR a.允许空 <> b.允许空
            OR a.默认值 <> b.默认值
            --OR a.字段说明 <> b.字段说明
    ORDER BY ISNULL(a.表名1, b.表名2),
            ISNULL(a.序号, b.序号)--isnull(a.字段名,b.字段名) 
