-- 分析统计-按周------------------------------------------------
-- EXECUTE [dbo].[proc_WeeklyStatistics_CreateTmpTable] @StartDate='2019-01-01',@EndDate='2019-02-15'
-- select * from [_WeeklyStatistics]
-- -----------------------------------------------------------------
ALTER PROCEDURE [dbo].[proc_WeeklyStatistics_CreateTmpTable] (
	@StartDate CHAR(10), -- 开始时间
	@EndDate CHAR(10), -- 结束时间
	@TruncateTmpTable bit -- 清空
) AS
BEGIN
-- 创建临时表------------------------------------------------------
IF NOT EXISTS(SELECT TOP 1 * FROM sysobjects WHERE id=OBJECT_ID(N'_WeeklyStatistics')) 
BEGIN
CREATE TABLE [_WeeklyStatistics] (
	[Id] int NOT NULL IDENTITY(1,1) PRIMARY KEY CLUSTERED, 
	[Y] int NOT NULL DEFAULT ((0)), 
	[M] int NOT NULL DEFAULT ((0)), 
	[D] int NOT NULL DEFAULT ((0)), 
	[DY] int NOT NULL DEFAULT ((0)), 
	[DY2] int NOT NULL DEFAULT ((0)), 
	[WM] int NOT NULL DEFAULT ((0)), 
	[WY] int NOT NULL DEFAULT ((0)), 
	[StartDate] char(10) NOT NULL, 
	[EndDate] char(10) NOT NULL,
	[State] int NOT NULL DEFAULT ((0))
) ON [PRIMARY]
END
IF (@TruncateTmpTable=1) TRUNCATE TABLE [_WeeklyStatistics];
-- 时间变量---------------------------------------------------------
DECLARE @Y INT=0, @M INT=0, @M2 INT=0, @D INT=0, @D2 INT=0, @DY INT=0, @DY2 INT=0, @WM INT=0, @WM2 INT=0, @WY INT=0, @WY2 INT=0, @tmpM INT=0, @tmpWY INT=0
DECLARE @OneDate datetime = @StartDate
DECLARE @EndWhile datetime = @EndDate
DECLARE @TmpDate CHAR(10) = @StartDate
DECLARE @TmpDate2 CHAR(10) = @StartDate
SET @M=datepart(month,@OneDate)
SET @D=datepart(day,@OneDate)
SET @DY=datepart(dayofyear,@OneDate)
SET @WM=datediff(week,dateadd(week,datediff(week,0,dateadd(month,datediff(month,0,@OneDate),0)),0),@OneDate-1)+1
SET @WY=datepart(week,@OneDate)
-- 开始循环-----------------------------------------------------------------
WHILE (@OneDate <= @EndWhile)
BEGIN
-- -----------------------------------------------------------------
SET @TmpDate2=CONVERT(CHAR(10),@OneDate,20)
SET @Y=datepart(year,@OneDate) --Year
SET @M2=datepart(month,@OneDate) --Month
SET @D2=datepart(day,@OneDate) --DayOfMonth
SET @DY2=datepart(dayofyear,@OneDate) --DayOfYear
SET DATEFIRST 1 -- 设置每周的起始天为周一
SET @WM2=datediff(week,dateadd(week,datediff(week,0,dateadd(month,datediff(month,0,@OneDate),0)),0),@OneDate-1)+1 --WeekOfMonth
IF @WM2=0 SET @M2=@M2-1; IF @M2=0 SET @M2=1; --Month Repair
SET @WY2=datepart(week,@OneDate) --WeekOfYear
IF (@tmpM < @M2 OR @WY2 > @tmpWY)
BEGIN
SET @tmpM=@M2
SET @tmpWY=@WY2
-- -----------------------------------------------------------------
IF (@DY <> @DY2)
BEGIN
INSERT INTO [_WeeklyStatistics]([Y],[M],[D],[DY],[DY2],[WM],[WY],[StartDate],[EndDate],[State])
SELECT @Y,@M,@D,@DY,@DY2,@WM,@WY,@TmpDate,@TmpDate2,0
END
-- -----------------------------------------------------------------
SET @M=@M2
SET @D=@D2
SET @DY=@DY2
SET @WM=@WM2
SET @WY=@WY2
SET @TmpDate=@TmpDate2
END
-- -----------------------------------------------------------------
SET @OneDate=DATEADD(day,1,@OneDate)
-- -----------------------------------------------------------------
END
INSERT INTO [_WeeklyStatistics]([Y],[M],[D],[DY],[DY2],[WM],[WY],[StartDate],[EndDate],[State])
SELECT @Y,@M,@D,@DY,@DY2,@WM,@WY,@TmpDate,@TmpDate2,0
-- 结束循环-----------------------------------------------------------------
END