@echo off
@echo ===================================
@echo    创建计划任务：定期清除数据库日志(只清理7天前的)
@echo ===================================
@echo 按 Ctrl + C 取消

@echo 备份当天的数据库日志
set sqlpath=d:/database_bak
sqlcmd -S localhost -U sa -P 123456 -i %sqlpath%/backup_log.sql

@echo off
@echo 清理7天前的日志
@forfiles /p %sqlpath% /s /m *.log /d -7 /c "cmd /c del /q @file"
@echo 清理完成
@pause