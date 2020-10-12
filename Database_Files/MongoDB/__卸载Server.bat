@echo off

sc stop Mongodb
sc delete Mongodb

Server\xxx\bin\mongod.exe --remove

pause
