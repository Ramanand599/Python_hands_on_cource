show databases;
use new_schema;
select * from new_schema.movie;
show tables;
/*
Syntax for general/basic query

For selecting entire data from the table
SELECT * FROM tablename;

For selecting specific columns from the table
SELECT col1,col2,col3,.... 
FROM tablename;
*/
# 1. 
select mov_id, mov_title,mov_year,mov_time from movie
where mov_id = 901;

# 2. 
select mov_id, mov_title,mov_year,mov_time from movie
where mov_rel_country = "USA";

/* 
ORDER BY - It is a clause used to sort the data either ascending or descending. 
Bybefault the data is sorted into ascending.

SELECT col1,col2,col3,...
FROM tablename
ORDER BY col1 ASC|DESC;

*/
select * from new_schema.ratings
order by rev_stars desc;

select * from new_schema.ratings
order by mov_id asc;

select * from new_schema.ratings
order by rev_stars desc
limit 3;

/*
SELECT amount
FROM payments
ORDER BY amount ASC
LIMIT 3
OFFSET (SELECT COUNT(*) - 3 FROM payments);
*/


# WHERE CLAUSE --------------------------------------
/*
The following shows the syntax of the WHERE clause:
SELECT 
    select_list
FROM
    table_name
WHERE
    search_condition;
    
# Operator Description
=	Equal to. You can use it with almost any data types.
<> or !=	Not equal to ==
<	Less than. You typically use it with numeric and date/time data types.
>	Greater than.
<=	Less than or equal to
>=	Greater than or equal to

# filtering operators
1. AND
2. OR
3. LIKE
4. IN 
5. BETWEEN
6. IS NULL 
*/
# Find actor id , first name as well as last name of actors who
--  have their first name as Joe.
select act_id,act_fname,act_lname from actor
where act_fname = "James";

# Find actor id , first name as well as last name of 
-- actors do not have their first name as Joe.
select act_id,act_fname,act_lname from actor
where act_fname != "Joe"
order by act_lname;


#  MySQL GROUP BY clause ----------------------

 /*
 SELECT 
    c1, c2,..., cn, aggregate_function(ci)
FROM
    table
WHERE
    where_conditions
GROUP BY c1 , c2,...,cn;
 */
 select act_gender,count(*) as totalid from actor
 group by act_gender;
 
 /*
The  HAVING clause is used for the SELECT statement to specify 
filter conditions for a group of rows or aggregates.
The following illustrates the syntax of the HAVING clause:

SELECT 
    select_list
FROM 
    table_name
WHERE 
    search_condition
GROUP BY 
    group_by_expression
HAVING 
    group_condition;
*/ 
# DISTINCT CLAUSE ---------------------------------------------
/*
Here is the syntax of the DISTINCT clause:

SELECT DISTINCT
    select_list
FROM
    table_name;
*/ 
select distinct act_lname from actor;
select distinct concat(act_fname, " " ,act_lname) as full_name from actor;
select distinct act_fname || " " || act_lname  as full_name from actor;
