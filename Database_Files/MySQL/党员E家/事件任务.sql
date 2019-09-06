SELECT @@event_scheduler;
SET GLOBAL event_scheduler=1;
show events;
select * from information_schema.events;

# 创建事件
CREATE EVENT if not exists e_userloginattemptsStatistics
ON SCHEDULE EVERY 1 DAY STARTS DATE_ADD(DATE_ADD(CURDATE(), INTERVAL 1 DAY), INTERVAL 1 HOUR)
ON COMPLETION PRESERVE ENABLE
DO
CALL dbstatistics.userloginattemptsStatistics();

