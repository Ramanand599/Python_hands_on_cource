# MySQL Joins ----------------------------------

/*

MySQL supports the following types of joins:

1. Inner join
2. Left join
3. Right join
4. Cross join

*/
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);
create table committees(
committee_id int AUTO_INCREMENT PRIMARY KEY,
name varchar(100)
);
insert into members(name)
values("JOHN"),("JANE"),("MARY"),("DAVID"),("AMELIA");
insert into committees(name)
values("JOHN"),("MARY"),("AMELIA"),("JOE");
select * from members;
select * from committees;
# 1. INNER JOIN -----
/*
The following shows the basic syntax 
of the inner join clause that joins two tables table_1 and table_2:
SELECT column_list
FROM table_1
INNER JOIN table_2 ON join_condition;

If the join condition uses the equal operator (=) 
and the column names in both tables used 
for matching are the same, you can use the USING clause instead:
SELECT column_list
FROM table_1
INNER JOIN table_2 USING (column_name);
*/
# 1. find members who are also the committee members:
SELECT 
    m.member_id, 
    m.name as `m name`, 
    c.committee_id, 
    c.name as `c name`
FROM
    members as m
INNER JOIN committees as c 
	ON c.name = m.name;
     
select
m.member_id,
m.name as members,
c.committee_id,
c.name as committee
from members m
inner join committees c 
using(name);

# 2. LEFT JOIN -----
/*
The following shows the basic syntax 
of the left join clause that joins two tables table_1 and table_2:

SELECT column_list 
FROM table_1 
LEFT JOIN table_2 ON join_condition;

If the join condition uses the equal operator (=) 
and the column names in both tables used 
for matching are the same, you can use the USING clause instead:

SELECT column_list 
FROM table_1 
LEFT JOIN table_2 USING (column_name);

*/
select
m.member_id,
m.name as members,
c.committee_id,
c.name as committee
from members m 
left join committees c
using(name);

# 3. RIGHT JOIN -----

/*
The following shows the basic syntax 
of the right join clause that joins two tables table_1 and table_2:

SELECT column_list 
FROM table_1 
RIGHT JOIN table_2 ON join_condition;

If the join condition uses the equal operator (=) 
and the column names in both tables used 
for matching are the same, you can use the USING clause instead:

SELECT column_list 
FROM table_1 
RIGHT JOIN table_2 ON join_condition;

*/
select
m.member_id,
m.name as members,
c.committee_id,
c.name as committee
from members m 
right join committees c
using(name);

# 4. CROSS JOIN 

/*
The following shows the basic syntax of the cross join clause:

SELECT select_list
FROM table_1
CROSS JOIN table_2;

*/
select
m.member_id,
m.name as members,
c.committee_id,
c.name as committee
from members m 
cross join committees c;

/* UNION - UNION is a set operation in SQL that combines the results of two or more SELECT statements into a single result set. 
The result set contains all the distinct rows from all the SELECT statements, eliminating any duplicates.

SELECT column1, column2 FROM table1
UNION
SELECT column1, column2 FROM table2;

The UNION operator can also be used with the ALL keyword to include duplicates in the result set.

SELECT column1, column2 FROM table1
UNION ALL
SELECT column1, column2 FROM table2;
*/
SELECT committee_id,NAME FROM committees
UNION 
SELECT member_id,NAME FROM members;
   
SELECT * FROM committees;
SELECT * FROM MEMBERS;

SELECT committee_id,NAME FROM committees
INTERSECT 
SELECT member_id,NAME FROM members;

/* INTERSECT - INTERSECT is a set operation in SQL that returns only the distinct rows that appear in both result sets of two SELECT statements. 
The result set of the INTERSECT operation contains only the rows that are common to both SELECT statements.

SELECT column1, column2 FROM table1
INTERSECT
SELECT column1, column2 FROM table2;

MySQL does not support the INTERSECT operator, which is used to combine the results of two or more SELECT statements 
and return only the rows that are common to all the SELECT statements. However, you can achieve the same result using other 
techniques such as INNER JOIN, EXISTS, or IN clauses.
*/