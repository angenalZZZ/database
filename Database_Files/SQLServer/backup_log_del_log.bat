@echo off
@echo ===================================
@echo    �����ƻ����񣺶���������ݿ���־(ֻ����7��ǰ��)
@echo ===================================
@echo �� Ctrl + C ȡ��

@echo ���ݵ�������ݿ���־
set sqlpath=d:/database_bak
sqlcmd -S localhost -U sa -P 123456 -i %sqlpath%/backup_log.sql

@echo off
@echo ����7��ǰ����־
@forfiles /p %sqlpath% /s /m *.log /d -7 /c "cmd /c del /q @file"
@echo �������
@pause