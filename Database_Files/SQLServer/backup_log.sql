use dbName

declare @bakfile nvarchar(200)
set @bakfile='d:\database_bak\log_bak_'+convert(nvarchar(8),getdate(),112)+'.log'
BACKUP LOG dbName TO DISK = @bakfile WITH RETAINDAYS = 1, COMPRESSION

DBCC SHRINKFILE (N'DBNAME_log', 1, TRUNCATEONLY)
