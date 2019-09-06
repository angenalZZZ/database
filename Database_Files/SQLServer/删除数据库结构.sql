--删除数据库结构：表、视图、函数、存储过程.
--指定数据库.
use enterpriseeducation_new
GO
--删除表
declare @name NVARCHAR(100)
declare @STMT NVARCHAR(200)
declare cursor1 cursor for
SELECT name FROM sysobjects WHERE type='U'
open cursor1
fetch next from cursor1 into @name
while @@fetch_status=0
BEGIN
--删除表的外键约束, 处理 ErrorMessage: Could not drop object '***' because it is referenced by a FOREIGN KEY constraint.
	declare @STMT2 NVARCHAR(200)
	declare cursor2 cursor for
	SELECT 'ALTER TABLE ['+OBJECT_SCHEMA_NAME(parent_object_id)+'].['+OBJECT_NAME(parent_object_id)+'] DROP CONSTRAINT ['+name+']' FROM sys.foreign_keys
	WHERE referenced_object_id=object_id(@name)
	open cursor2
	fetch next from cursor2 into @STMT2
	while @@fetch_status=0
	begin
		EXEC SP_EXECUTESQL @STMT=@STMT2
		fetch next from cursor2 into @STMT2
	end
	close cursor2
	deallocate cursor2
	SET @STMT=N'DROP TABLE '+@name
	EXEC SP_EXECUTESQL @STMT=@STMT
	fetch next from cursor1 into @name
END
close cursor1
deallocate cursor1
--删除视图
declare cursor1 cursor for
SELECT name FROM sysobjects WHERE type='V'
open cursor1
fetch next from cursor1 into @name
while @@fetch_status=0
BEGIN
	SET @STMT=N'DROP VIEW '+@name
	EXEC SP_EXECUTESQL @STMT=@STMT
	fetch next from cursor1 into @name
END
close cursor1
deallocate cursor1
--删除函数
declare cursor1 cursor for
SELECT name FROM sysobjects WHERE type='FN' OR type='IF' OR type='TF'
open cursor1
fetch next from cursor1 into @name
while @@fetch_status=0
BEGIN
	SET @STMT=N'DROP FUNCTION '+@name
	EXEC SP_EXECUTESQL @STMT=@STMT
	fetch next from cursor1 into @name
END
close cursor1
deallocate cursor1
--删除存储过程
declare cursor1 cursor for
SELECT name FROM sysobjects WHERE type='P'
open cursor1
fetch next from cursor1 into @name
while @@fetch_status=0
BEGIN
	SET @STMT=N'DROP PROCEDURE '+@name
	EXEC SP_EXECUTESQL @STMT=@STMT
	fetch next from cursor1 into @name
END
close cursor1
deallocate cursor1
