-- DB数据库列表
show databases;

-- 1.DB连接池中保持的最大空闲连接 Command='Sleep';
-- 2.DB查询Query正常连接 Command='Query';
show processlist;

-- 修改密码
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('HGJ766GR767FKJU0');
SET PASSWORD FOR 'root'@'%' = PASSWORD('HGJ766GR767FKJU0');
FLUSH PRIVILEGES;

-- 表的字段
SET @tablename='PartyCreditRuleLog';
SELECT GROUP_CONCAT(COLUMN_NAME SEPARATOR ",") COLUMNS FROM information_schema.COLUMNS WHERE TABLE_NAME=@tablename 
UNION SELECT COLUMN_NAME FROM information_schema.COLUMNS WHERE TABLE_NAME=@tablename; -- AND TABLE_SCHEMA='db_name'

-- 事件
SELECT @@event_scheduler;
SET GLOBAL event_scheduler=1;
show events;
select * from information_schema.events;

-- 创建事件
CREATE EVENT IF NOT EXISTS e_userloginattemptsStatistics
ON SCHEDULE EVERY 1 DAY
STARTS '2019-08-30 01:00:00.000' --STARTS DATE_ADD(DATE_ADD(CURDATE(), INTERVAL 1 DAY), INTERVAL 1 HOUR)
ON COMPLETION PRESERVE ENABLE
DO CALL dbstatistics.statistics();

