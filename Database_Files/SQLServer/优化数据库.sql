--CPU占用高的20条语句(60分钟内) 
SELECT TOP 20 db_name(qp.dbid) [db_name], last_execution_time, 
 (SELECT SUBSTRING(text,statement_start_offset/2+1,(CASE WHEN statement_end_offset=-1 THEN LEN(CONVERT(nvarchar(max),text))*2 
 ELSE statement_end_offset END - statement_start_offset)/2) FROM sys.dm_exec_sql_text(sql_handle)) [sql],
 total_worker_time/execution_count [avg_cpu], total_elapsed_time/execution_count [avg_time], execution_count [count]
FROM sys.dm_exec_query_stats qs CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) as qp 
WHERE 'EnterpriseEducation'=db_name(qp.dbid) and last_execution_time>DATEADD(MINUTE,-60,GETDATE()) 
ORDER BY [avg_cpu] DESC


-- 19998
SELECT TOP 100 * FROM (SELECT last_execution_time, 
 (SELECT SUBSTRING(text,statement_start_offset/2+1,(CASE WHEN statement_end_offset=-1 THEN LEN(CONVERT(nvarchar(max),text))*2 
 ELSE statement_end_offset END - statement_start_offset)/2) FROM sys.dm_exec_sql_text(sql_handle)) [sql],
 total_worker_time/execution_count [avg_cpu], total_elapsed_time/execution_count [avg_time], execution_count [count]
FROM sys.dm_exec_query_stats WHERE last_execution_time>DATEADD(MINUTE,-100,GETDATE())
)t where [sql] like '%Sys_Account%'
ORDER BY [last_execution_time] DESC


GO
-- 优化数据库
CREATE PROCEDURE [dbo].[proc_statistics_tables] AS
BEGIN
-- 数据库FEI_DataCenter
	DECLARE @bcid nvarchar(20), @sql nvarchar(200)
	IF NOT EXISTS(SELECT TOP 1 name FROM sysobjects WHERE id=OBJECT_ID('_bcid'))
	BEGIN
		set @sql=N'CREATE TABLE dbo._bcid (bcid nvarchar(20))'
		exec sp_executesql @sql
	END
	INSERT INTO _bcid (bcid)
	SELECT convert(nvarchar(20),f1.bcid) FROM FEI_MALL.dbo.fei_bcompanys f1 WITH(NOLOCK) 
		INNER JOIN FEI_MALL.dbo.fei_bcompany_syncconfig f2 WITH(NOLOCK) ON f1.bcid=f2.bcid
	SELECT TOP 1 @bcid=bcid FROM _bcid
	WHILE EXISTS(SELECT TOP 1 id FROM sysobjects WHERE id=OBJECT_ID('__salesorder_detail'+@bcid))
	BEGIN
		DELETE FROM _bcid WHERE bcid=@bcid
		set @sql=N'UPDATE STATISTICS __salesorder_detail'+@bcid
		IF EXISTS(SELECT TOP 1 id FROM sysobjects WHERE id=OBJECT_ID('__salesorder_detail'+@bcid+'_edit'))
			set @sql=@sql+N'\n UPDATE STATISTICS __salesorder_detail'+@bcid+'_edit'
		set @bcid=isnull((SELECT TOP 1 bcid FROM _bcid),0)
		exec sp_executesql @sql
	END
	
-- 数据库FEI_MALL
	UPDATE STATISTICS FEI_MALL.dbo.fei_appid_pubsub
	UPDATE STATISTICS FEI_MALL.dbo.fei_appid_pubsub_billapply
	UPDATE STATISTICS FEI_MALL.dbo.fei_billapply
	UPDATE STATISTICS FEI_MALL.dbo.fei_billapply_detail
	UPDATE STATISTICS FEI_MALL.dbo.fei_billapply_invoice
	UPDATE STATISTICS FEI_MALL.dbo.fei_invoice
	UPDATE STATISTICS FEI_MALL.dbo.fei_users
	
END