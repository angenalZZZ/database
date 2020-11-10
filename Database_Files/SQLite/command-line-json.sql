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
