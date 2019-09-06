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
