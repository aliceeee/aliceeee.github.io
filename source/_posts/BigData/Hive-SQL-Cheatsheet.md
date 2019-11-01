---
title: Hive SQL Cheatsheet
date: 2019-11-01 16:32:45
tags:
    - hive
    - sql
    - cheatsheet
categories:
    - Tech
---

<!-- more -->

# DDL

删除表
```sql
drop table if exists tmp_table;
```

创建表
```sql
create table tmp_table(
	name string,
	hobby array<string>,
	add map<String,string>
)
partitioned by (dt string comment 'date', hm string comment 'hour and minut')
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
collection items terminated by '-'
map keys terminated by ':'
;
```

创建分区
```sql
alter table tmp_table add partition(dt='20190101', hm='0000') partition(dt='20190101', hm='0100');
```

插入数据
```sql
insert into table tmp_table partition(dt='20190101', hm='0000')  
select 'a', array('sing,dance'),  str_to_map('a:1,b:2') ;
```    

查看
```sql
show create table  temp_vip_realtime_feature.tmp_table;
show partitions  temp_vip_realtime_feature.tmp_table;
```

# 字符串

替换
```sql
select regexp_replace('[a,b,c]','\\[|\\]','') -- 把方括号替换
``` 

多行拼接
```sql
-- slow, why?
select concat_ws(',',collect_set(val)) from 
	dual
	lateral view  explode(array('a','b','c','a')) tmp_table as val; 
``` 

# 日期

```sql
select unix_timestamp();  -- 当前时间戳：1572425940
select current_timestamp();  -- 当前日期：2019-10-30 16:59:24.24
select date_add('2019-10-31', 1); -- tomorrow
select date_sub('2019-10-31', 1); -- yesterday

select unix_timestamp('2018-06-29 00:00:00'); -- string to timestamp: 1530201600
select unix_timestamp('2018/06/29 09', 'yyyy/MM/dd HH'); -- string to timestamp: 1530234000

select from_unixtime(1356768454, 'yyyy-MM-dd HH:mm:ss'); -- timestamp to string
```

# 内置UDTF

数组转表
```sql
select  explode(array('a','b','c')) as col;

select table_b.col 
from dual 
lateral view explode(array('a','b','c','a')) table_b as col; -- UDTF cannot be used in select
```

JSON转表
```sql
select get_json_object('{"a":1,"b":2}','$.a') as col;

select get_json_object('{"list":[{"a":1},{"a":11},{"a":111}]}','$.list.a') ;
```

```sql
select * 
from tmp_table 
lateral view json_tuple('{"a":1,"b":2}','a','b') tmp_json as col_a, col_b;
```



