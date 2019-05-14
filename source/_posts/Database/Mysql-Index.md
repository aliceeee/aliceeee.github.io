---
title: Mysql Index
tags:
    - mysql
    - index
    - todo
categories:
    - Tech

date: 2019-05-07 15:05:49
---

<!-- more -->

# 创建官方测试库

> 官方 [Employees Sample Database](https://dev.mysql.com/doc/employee/en/)
> Git: https://github.com/datacharmer/test_db

1. MySQL 5.5+

2. Download the repository

3. Change directory to the repository
Then run
```
mysql < employees.sql
```

# 基本操作

> See https://www.runoob.com/mysql/mysql-index.html

修改表结构(添加索引)
```sql
ALTER TABLE tbl_name ADD PRIMARY KEY (column_list); -- 该语句添加一个主键，这意味着索引值必须是唯一的，且不能为NULL。
ALTER TABLE tbl_name ADD UNIQUE index_name (column_list); --  这条语句创建索引的值必须是唯一的（除了NULL外，NULL可能会出现多次）。
ALTER TABLE tbl_name ADD INDEX index_name (column_list); --  添加普通索引，索引值可出现多次。
ALTER TABLE tbl_name ADD FULLTEXT index_name (column_list); -- 该语句指定了索引为 FULLTEXT ，用于全文索引。
```

创建表的时候直接指定
```sql
CREATE TABLE mytable(  
    ID INT NOT NULL,   
    username1 VARCHAR(16) NOT NULL,  
    username2 VARCHAR(16) NOT NULL,  
    INDEX [indexName] (username1(length))  ,
    UNIQUE [indexName] (username2(length))  
);  
```

删除索引的语法
```sql
DROP INDEX [indexName] ON mytable; 
ALTER TABLE tbl_name DROP INDEX index_name;
```

查看索引
```sql
SHOW INDEX FROM table_name;
```

查看索引大小
```sql
USE `information_schema`;

SELECT CONCAT(ROUND(SUM(index_length)/(1024*1024), 2), ' MB') AS 'Total Index Size' FROM `TABLES` WHERE table_name = 'dept_emp'; 
```


# Index Type



## const

```
EXPLAIN SELECT * FROM employees.titles WHERE emp_no='10001' AND title='Senior Engineer' AND from_date='1986-06-26';
+----+-------------+--------+-------+---------------+---------+---------+-------------------+------+-------+
| id | select_type | table  | type  | possible_keys | key     | key_len | ref               | rows | Extra |
+----+-------------+--------+-------+---------------+---------+---------+-------------------+------+-------+
|  1 | SIMPLE      | titles | const | PRIMARY       | PRIMARY | 59      | const,const,const |    1 |       |
+----+-------------+--------+-------+---------------+---------+---------+-------------------+------+-------+
```

理论上索引对顺序是敏感的，但是由于MySQL的查询优化器会自动调整where子句的条件顺序以使用适合的索引


