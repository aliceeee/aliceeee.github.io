---
title: Mysql Basis
date: 2019-05-09 15:57:04
tags:
    - mysql
    - todo
categories:
    - Tech

---

<!-- more -->

# 关键字

## distinct

```sql
SELECT DISTINCT(gender) FROM employees;

gender  
--------
M       
F     
```

但是以下情况失效。这时适合用group by
```sql
SELECT DISTINCT(gender), emp_no FROM employees;
SELECT gender, emp_no FROM employees GROUP BY gender;
```
