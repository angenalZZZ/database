-- #json.db tutorial: https://www.sqlite.org/json1.html
-- > cd A:\database\sqlite && md data
-- > sqlite3 -list
-- > create table logs(data json);
-- > insert into logs values(json_object("name", "foo1", "value", "ber1"));
-- > insert into logs values(json('{"name": "foo2", "value": "ber2"}'));
-- > select * from logs;
-- > select json_extract(data,"$.name") as name from logs;
-- > .save 'data/json.db'
-- > .quit

select * from logs limit 10 offset 0;

CREATE TABLE [logtest] (
	[Id] integer NOT NULL PRIMARY KEY AUTOINCREMENT, 
	[Code] varchar(50) NOT NULL, 
	[Type] int NOT NULL, 
	[Message] nvarchar(2000) NOT NULL, 
	[Account] varchar(36), 
	[CreateTime] datetime NOT NULL, 
	[CreateUser] varchar(36)
);
