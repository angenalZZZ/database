-- 拆分字符串: select * from dbo.fn_split('1,2,3,4',',')
CREATE FUNCTION [dbo].[fn_split] (
	@string        VARCHAR(MAX),
	@separator     VARCHAR(10)
)
RETURNS TABLE
AS
RETURN 
(
    SELECT B.id
    FROM   (
               (
                   SELECT [value] = CONVERT(XML, '<v>' + REPLACE(@string, @separator, '</v><v>') + '</v>')
               ) A 
               OUTER APPLY
               (
                   SELECT id = N.v.value('.', 'varchar(100)') FROM   A.[value].nodes('/v') N(v)
               ) B
           )
)
GO
-- 拆分字符串: select * from dbo.fn_split_top('1,2,3,4',',',2,1)
CREATE FUNCTION [dbo].[fn_split_top] (
	@string        VARCHAR(MAX),
	@separator     VARCHAR(10),
	@offset        int,
	@take          int = 1
)
RETURNS TABLE
AS
RETURN 
(
    SELECT B.id
    FROM   (
               (
                   SELECT [value] = CONVERT(XML, '<v>' + REPLACE(@string, @separator, '</v><v>') + '</v>')
               ) A 
               OUTER APPLY
               (
                   SELECT id = N.v.value('.', 'varchar(100)') FROM   A.[value].nodes('/v') N(v)
               ) B
           )
     ORDER BY B.id offset @offset ROWS FETCH NEXT @take ROWS ONLY
)
GO
-- 拆分字符串: select * from dbo.fn_split2id('1,A;2,B;3,C;4,D',';',',')
CREATE FUNCTION [dbo].[fn_split2id] (
	@ids varchar(max),
	@spl char(1)=';',@spr char(1)=','
)
RETURNS @tbl TABLE (i varchar(100),d varchar(100))
AS
BEGIN
declare @i int
declare @id varchar(100)
set @ids=@ids+@spl
set @i=charindex(@spl,@ids)
while @i<>0
begin
	set @id=substring(@ids,1,@i-1)
	IF @id<>'' INSERT INTO @tbl(i,d) VALUES(substring(@id,1,charindex(@spr,@id)-1),substring(@id,charindex(@spr,@id)+1,len(@id)))
	set @ids=substring(@ids,@i+1,(len(@ids)-@i))
	set @i=charindex(@spl,@ids)
end
RETURN
END
GO
-- 拆分字符串: select * from dbo.fn_split2ids('1,2,3,4','A,B,C,D','Arial,Beel,Core,Do',',')
CREATE FUNCTION [dbo].[fn_split2ids] (
	@ids varchar(max),
	@dds varchar(max),
	@sds varchar(max),
	@spl char(1)=','
)
RETURNS @tbl TABLE (i varchar(100),d varchar(100),s varchar(100))
AS
BEGIN
declare @i int,@d int,@s int
declare @id varchar(100),@dd varchar(100),@sd varchar(100)
set @ids=@ids+@spl;set @dds=@dds+@spl;set @sds=@sds+@spl
set @i=charindex(@spl,@ids);set @d=charindex(@spl,@dds);set @s=charindex(@spl,@sds)
while @i<>0 and @d<>0 and @s<>0
begin
	set @id=substring(@ids,1,@i-1);set @dd=substring(@dds,1,@d-1);set @sd=substring(@sds,1,@s-1)
	IF @id<>'' and @dd<>'' and @sd<>'' INSERT INTO @tbl(i,d,s) VALUES(@id,@dd,@sd)
	set @ids=substring(@ids,@i+1,(len(@ids)-@i));set @dds=substring(@dds,@d+1,(len(@dds)-@d));set @sds=substring(@sds,@s+1,(len(@sds)-@s))
	set @i=charindex(@spl,@ids);set @d=charindex(@spl,@dds);set @s=charindex(@spl,@sds)
end
RETURN
END
GO
-- 日期格式: select dbo.datepartf(datepart(year,getdate()),'',4)+'-'+dbo.datepartf(datepart(month,getdate()),'0',2)+'-'+dbo.datepartf(datepart(day,getdate()),'0',2)
CREATE FUNCTION [dbo].[datepartf] (@Source nvarchar(20),@PaddingChar nchar(1),@TotalWidth tinyint) 
RETURNS nvarchar(20) AS BEGIN DECLARE @Result nvarchar(20) 
SELECT @Result = REPLICATE(@PaddingChar, @TotalWidth - LEN(@Source)) + @Source 
RETURN @Result 
END
GO
-- 日期按周统计: SET DATEFIRST 1; select * from dbo.fn_createWeeklyStatisticsTable('2019-01-01','2019-02-15');
DROP FUNCTION [dbo].[fn_createWeeklyStatisticsTable];
GO
CREATE FUNCTION [dbo].[fn_createWeeklyStatisticsTable] (
	@StartDate CHAR(10), -- 开始时间
	@EndDate CHAR(10) -- 结束时间
)
RETURNS @tbl TABLE ([Id] int NOT NULL IDENTITY(1,1) PRIMARY KEY CLUSTERED, [Y] int NOT NULL DEFAULT ((0)), [M] int NOT NULL DEFAULT ((0)), [D] int NOT NULL DEFAULT ((0)), [DY] int NOT NULL DEFAULT ((0)), [DY2] int NOT NULL DEFAULT ((0)), [WM] int NOT NULL DEFAULT ((0)), [WY] int NOT NULL DEFAULT ((0)), [StartDate] char(10) NOT NULL, [EndDate] char(10) NOT NULL, [State] int NOT NULL DEFAULT ((0)))
AS
BEGIN
--SET DATEFIRST 1 --设置每周的起始天为周一
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
WHILE (@OneDate <= @EndWhile)
BEGIN
SET @TmpDate2=CONVERT(CHAR(10),@OneDate,20)
SET @Y=datepart(year,@OneDate) -- Year
SET @M2=datepart(month,@OneDate) -- Month
SET @D2=datepart(day,@OneDate) -- DayOfMonth
SET @DY2=datepart(dayofyear,@OneDate) -- DayOfYear
SET @WM2=datediff(week,dateadd(week,datediff(week,0,dateadd(month,datediff(month,0,@OneDate),0)),0),@OneDate-1)+1 -- WeekOfMonth
IF @WM2=0 SET @M2=@M2-1; IF @M2=0 SET @M2=1;
IF @D>29 AND @WM=5 AND @DY2-@DY<3 BEGIN SET @tmpM=@M2; SET @M=@M+1; SET @WM=1; SET @D=1; END -- Month Repair
SET @WY2=datepart(week,@OneDate) -- WeekOfYear
IF (@tmpM < @M2 OR @WY2 > @tmpWY)
BEGIN
SET @tmpM=@M2
SET @tmpWY=@WY2
IF (@DY <> @DY2)
BEGIN
INSERT INTO @tbl([Y],[M],[D],[DY],[DY2],[WM],[WY],[StartDate],[EndDate],[State])
SELECT @Y,@M,@D,@DY,@DY2,@WM,@WY,@TmpDate,@TmpDate2,0
END
SET @M=@M2
SET @D=@D2
SET @DY=@DY2
SET @WM=@WM2
SET @WY=@WY2
SET @TmpDate=@TmpDate2
END
SET @OneDate=DATEADD(day,1,@OneDate)
END
INSERT INTO @tbl([Y],[M],[D],[DY],[DY2],[WM],[WY],[StartDate],[EndDate],[State])
SELECT @Y,@M,@D,@DY,@DY2,@WM,@WY,@TmpDate,@TmpDate2,0
RETURN
END
Go
