## STORED PROCEDURE -------------------------------------------------
/*
If you want to save any query on the database server for execution later, 
one way to do it is to use a stored procedure.

By definition, a stored procedure is a segment of declarative SQL statements 
stored inside the MySQL Server.

Advantages:
1. Reduce network traffic
2. Centralize business logic in the database
3. Make database more secure

Disadvantages :
1. Resource usages
2. Troubleshooting
3. Maintenances

# General Syntax 
DELIMITER $$

CREATE PROCEDURE sp_name()
BEGIN
  -- statements
END $$

DELIMITER ;

*/
# CREATE PROCEDURE statement creates a new stored procedure that 
-- wraps the query above
DELIMITER $$
CREATE PROCEDURE stp_GetCustomers()
BEGIN
	SELECT 
		customerName, 
		city, 
		state, 
		postalCode, 
		country
	FROM
		customers
	ORDER BY customerName;    
     END$$
DELIMITER ;

#  invoke it by using the CALL statement
CALL stp_GetCustomers(); 

#####################subquery######################
/* MySQL Subquery ------------------------
SELECT column1, column2
FROM table1
WHERE column1 IN (SELECT column1 FROM table2 WHERE column3 = 'value');
*/

# 1. select all the employees who work in offices located in the USA.
 select * from employees;
 select * from offices;
 
Select lastname,firstname from employees
inner join offices
on employees.officeCode = offices.officeCode
where country = 'USA';

Select lastname,firstname from employees
inner join offices using(officecode)
where country = 'USA';

            
SELECT 
    lastName, firstName
FROM
    employees
WHERE
    officeCode in (SELECT 
            officeCode
        FROM
            offices
        WHERE
            country = 'USA');
            
 # 2. select customer who has the maximum payment
SELECT 
    customerNumber, 
    checkNumber, 
    amount
FROM
    payments
WHERE
    amount = (SELECT MAX(amount) FROM payments);      
    
 # 3. find customers whose payments are greater 
# than the average payment using a subquery
select avg(amount) from payments;

SELECT 
    customerNumber, 
    checkNumber, 
    amount
FROM payments
WHERE amount > (SELECT 
            AVG(amount)
        FROM
            payments);
            
 # 4.  find the customers who have not placed any orders
select * from customers;
select * from orders;

SELECT 
    customerName
FROM
    customers
WHERE
    customerNumber NOT IN (SELECT 
            customerNumber
        FROM
            orders);        
            
/*Correlated sub-query:
A correlated subquery is a type of subquery in SQL that is executed for each row processed by the outer query. 
The subquery references one or more columns from the outer query, which are used to filter the results of the subquery.
*/

SELECT customerNumber, 
    customername
FROM customers
WHERE not exists (SELECT customerNumber FROM orders  WHERE customers.customerNumber = orders.customerNumber);

            
# VIEWS  
/*
MySQL allows you to create a view based on a SELECT statement that retrieves 
data from one or more tables. 
*/
##################### View 1 ##################################

# This statement uses the CREATE VIEW statement to create a view 
# that represents total sales per order.

CREATE VIEW salePerOrder AS(
    SELECT 
        orderNumber, 
        SUM(quantityOrdered * priceEach) total
    FROM
        orderDetails
        
    GROUP by orderNumber
    ORDER BY total DESC);

 # execute a simple SELECT  statement against the SalePerOrder  view as follows:
SELECT * FROM salePerOrder;   

##################### View 2 ##################################
# Creating a view based on another view example
# you can create a view called bigSalesOrder based on the 
# salesPerOrder view to show every sales order whose total is 
# greater than 60,000 as follows:
CREATE VIEW bigSalesOrder AS(
    SELECT 
        orderNumber, 
        ROUND(total,2) as total
    FROM
        salePerOrder
    WHERE
        total > 60000);
# Now, you can query the data from the bigSalesOrder view as follows:
SELECT *
FROM bigSalesOrder; 
##################### View 3 ##################################
# Creating a view with join example    
 # CREATE VIEW statement to create a view based on multiple tables. 
 # It uses the INNER JOIN clauses to join tables.
CREATE VIEW customerOrders AS(
SELECT 
    orderNumber,
    customerName,
    SUM(quantityOrdered * priceEach) total
FROM
    orderDetails
INNER JOIN orders  USING (orderNumber)
INNER JOIN customers USING (customerNumber)
GROUP BY orderNumber);

# This statement selects data from the customerOrders view:
SELECT * FROM customerOrders 
ORDER BY total DESC;

##################### View 4 ##################################
# Creating a view with a subquery example
# The view contains products whose buy prices are higher than the 
# average price of all products.
CREATE VIEW aboveAvgProducts AS
    SELECT 
        productCode, 
        productName, 
        buyPrice
    FROM products
    WHERE buyPrice > (
            SELECT 
                AVG(buyPrice)
            FROM
                products)
    ORDER BY buyPrice DESC;

# This query data from the aboveAvgProducts is simple as follows:

SELECT * FROM aboveAvgProducts;            

/*
Materialized View:
A materialized view is a database object that stores the results of a query and provides fast access to the precomputed 
results, rather than computing the results on the fly each time the query is executed.
*/
CREATE VIEW salesTotal AS(
    SELECT 
        orderNumber, 
        SUM(quantityOrdered * priceEach) total
    FROM
        orderDetails
        
    GROUP by orderNumber
    ORDER BY total DESC);
    
CREATE TABLE my_materialized_view (
  orderNumber int,
  total decimal(10,2)
);

INSERT INTO my_materialized_view (orderNumber, total)
SELECT orderNumber, total
FROM salestotal;

select * from my_materialized_view;