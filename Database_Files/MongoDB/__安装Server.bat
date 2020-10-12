@echo off

@md D:\Program\MongoDB\backup
@md D:\Program\MongoDB\data
@md D:\Program\MongoDB\log

D:\Program\MongoDB\Server\xxx\bin\mongod.exe --install --serviceName Mongodb --serviceDisplayName Mongodb --config D:\Program\MongoDB\mongod.cfg --bind_ip 127.0.0.1 --directoryperdb --maxConns 400

net start Mongodb

pause