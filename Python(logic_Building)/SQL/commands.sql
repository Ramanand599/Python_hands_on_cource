/* What are the different type of SQL Statements  or Commands in SQL
 There are 5 types of Statements or Commands in mysql
1) DDL (Data Defination Language)
2) DML (Data Manipulation Language)
3) DQL (Data Query Language)
4) DCL (Data Control Language)
5) TCL (Transaction Control Language)
*/
/*     DDL(Data Defination Language)
i) DDL is a SQL Commands to define the database schema
ii) It is used to Create or Modify the Structure of the Database object
 in the DB.
Note:-
1) We don't use Where clause in DDL
2) You cannot use rollback statement to restore the data because 
it is autocommit 

There are totaly 4 commands in DDL
1) Create
2) Drop
3) Alter 
4) Truncate
*/

#create database
create database new;
create database if not exists new;

# Drop database
create database if not exists temp;
show databases;
drop database temp;
drop database new;
drop database if exists practics;

# MYSQL	 CREATE TABLE ------------------------
/*
The following illustrates the basic syntax of the CREATE TABLE  statement:
CREATE TABLE [IF NOT EXISTS] TABLE_NAME(
column_1_defination,
column_2_defination,
-------------------
table_constaints
) ENGINE = STORAGE_ENGINE;
*/

CREATE DATABASE MYDEB;
#DROP DATABASE IF EXISTS MYDEB;
SHOW ENGINES;
use mydeb;

# Create table
create table test1(
col1 int,
col2 varchar(256));
select * from test1;
describe test1;

create table if not exists task(
task_id int auto_increment primary key,
title varchar(200),
start_date date,
due_date date,
status tinyint not null,
priority tinyint not null,
description text,
created_at timestamp default current_timestamp
) engine = innodb;
show engines;
describe task;
select current_timestamp();
CREATE TABLE empl (
    emp_no INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50) DEFAULT 'xyz',
    email VARCHAR(80) NOT NULL
);
# MySQL INSERT statement -------------------
/*
 insert multiple rows into a table using a 
 single INSERT statement, 
 you use the following syntax
INSERT INTO table(c1,c2,...)
VALUES 
   (v11,v12,...),
   (v21,v22,...),
    ...
   (vnn,vn2,...);
   */
insert into empl(first_name, last_name,email)
values ('John' , 'Doe','john@yahoo.com' ),
	   ('Mary' , 'Jane','mary2323@email.com');    

insert into empl(first_name, email)
values ('asdf' , 'abc'),
       ('Mary' , 'abc');     
select * from empl;	      
Truncate  table empl;
# create a new table 
CREATE TABLE IF NOT EXISTS task2(
    task_id INT AUTO_INCREMENT, 
    title VARCHAR(255) NOT NULL,
    start_date DATE,
    due_date DATE,
    priority TINYINT NOT NULL DEFAULT 3,
    description TEXT,
    PRIMARY KEY (task_id)
);

# 1.  insert a new row into the task2 table
insert into task2(title,priority)
values("HEllo World",1);
describe task2;
select current_timestamp();

# 2. Add date
insert into task2(title,start_date,due_date)
values("Insert date into table","2018-01-09","2018-09-15");
select current_date();

# 3. Add current date
insert into task2(title,start_date,due_date)
values("Use current date for the class",current_date(),current_date());

# 4. insert three row into the task table
insert into task2(title,priority)
values("My first task",1),
("It is the second task",2),
("This is my third task of the week",3);
truncate table task2;

-- Alter :- To add column (or) to Modify the datatype
/*
To add a column to a table, you use the ALTER TABLE ADD syntax:
# ADD
ALTER TABLE table_name
    ADD new_column_name column_definition,
    ADD new_column_name column_definition,
    ...;
    
To modify the columns in the table.
# MODIFIY 
ALTER TABLE table_name
    MODIFY column_name column_definition,
    MODIFY column_name column_definition,
    ...;
*/
# 1. Add two columns in above table
select * from empl;
truncate table empl;

alter table empl
add city varchar(50),
add email2 varchar(255);
select * from empl;


# 2. modify table column
describe empl;

alter table empl
modify email varchar(100) not null;
describe empl;

# 3. rename column
alter table empl
change column city addr varchar(255);
describe empl;

# 4. Droping the  columns from table.
alter table empl
drop column email2;
select * from empl;

# 5. rename table empl to test
alter table empl
rename to test;
select * from test;
describe test;

# 6. Drop table test
drop table task;
select * from task;
drop table if exists task;

-- Update :- Update is used to update a value in a particular row or value for entire 
-- column if where is not specified.
# MySQL UPDATE statement
/*
The following illustrates the basic syntax of the UPDATE statement:
UPDATE  table_name 
SET 
    column_name1 = expr1,
    column_name2 = expr2,
    ...
[WHERE
    condition];
*/
 -- Delete :- Delete is used to Delete Perticular Row
 # 1. delete all records from the task table
 select * from test1;
 delete from test;
 drop table test1;
 
 select * from test;
 truncate table test;
 insert into test
 values("2","Shivam","rasad","anglore","Raran@gmail.com");
 select * from test;
 delete from test where first_name="Karan";
 
 select * from test;
describe test;
truncate table test;
insert into test values('1','Karna','Prasad','Bangalore','karna@yahoo.com');
select * from test;
insert into test values('2','Riya','Sharma','Pune','riyas@email.com');
delete from test where first_name='Riya';

/* DCL [Data Control Language]                      # If you want to work on it go to server -> users and privileges -> Add account ->
Data Control Language is used to give privileages (permission) to the user to perform any operation in the database

1) Grant 
2) Revoke 
*/


 