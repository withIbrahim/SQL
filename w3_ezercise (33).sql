/*1. Write a SQL statement that displays all the information about all salespeople.*/

SELECT * FROM salesman

/*2. Write a SQL statement to display a string "This is SQL Exercise, Practice and Solution".*/

SELECT 'This is SQL Exercise, Practice and Solution'

/*3 Write a SQL query to display three numbers in three columns.*/

SELECT 10,15,20

/* 4. Write a SQL query to display the sum of two numbers 10 and 15 from the RDBMS server. */

SELECT SUM(10+15)

SELECT 10+15

/* 5. Write an SQL query to display the result of an arithmetic expression.  */


SELECT 10+30-10*2

--10+(30-(10*2)) THIS IS THE ARTHMETIC EXP.


/*6. Write a SQL statement to display specific columns such as names and commissions for all salespeople.*/


SELECT 
	NAME,COMMISSION
FROM salesman


/* 7. Write a query to display the columns in a specific order, such as order date, salesman ID, order number, 
      and purchase amount for all orders. */

SELECT 
	ORD_NO,
	ORD_DATE,
	SALESMAN_ID,
	ORD_NO,
	PURCH_AMT
FROM orders


/*8. From the following table, write a SQL query to identify the unique salespeople ID. Return salesman_id.*/

SELECT
	DISTINCT(SALESMAN_ID)
FROM orders


/*
9. From the following table, write a SQL query to locate salespeople who live in the city of 'Paris'. Return salesperson's name, city.
*/

SELECT
	NAME,
	CITY
FROM salesman
WHERE CITY = 'Paris'

/*
10. write a SQL query to find customers whose grade is 200. Return customer_id, cust_name, city, grade, salesman_id.
*/

SELECT
	*
FROM customer
WHERE grade = 200

/*
11. write a SQL query to find orders that are delivered by a salesperson with ID. 5001. Return ord_no, ord_date, purch_amt. */

SELECT
	ORD_NO,
	ORD_DATE,
	PURCH_AMT
FROM orders
WHERE SALESMAN_ID = 5001




CREATE TABLE nobel_win(
	YEAR INT NOT NULL,
	SUBJECT  VARCHAR (30)NOT NULL,
	WINNER  VARCHAR (30) NOT NULL,
	COUNTRY VARCHAR (30) NOT NULL,
	CATEGORY VARCHAR (30) NOT NULL
	)



INSERT INTO nobel_win VALUES 
(1970, 'Physics','Hannes Alfven','Sweden','Scientist'),
(1970, 'Physics','Louis Neel','France','Scientist'),
(1970, 'Chemistry','Luis Federico Leloir','France','Scientist'),
(1970, 'Physiology','Ulf von Euler','Sweden','Scientist'),
(1970,'Physiology','Bernard Katz','Germany','Scientist'),
(1970, 'Literature', 'Aleksandr Solzhenitsyn','Russia','Linguist'),
(1970, 'Economics','Paul Samuelson','USA','Economist'),
(1970, 'Physiology','Julius Axelrod','USA','Scientist'),
(1971, 'Physics','Dennis Gabor','Hungary','Scientist'),
(1971, 'Chemistry','Gerhard Herzberg','Germany','Scientist'),
(1971, 'Peace','Willy Brandt','Germany','Chancellor'),
(1971, 'Literature','Pablo Neruda','Chile','Linguist'),
(1971, 'Economics','Simon Kuznets','Russia','Economist'),
(1978, 'Peace','Anwar al-Sadat','Egypt','President'),
(1978, 'Peace','Menachem Begin','Israel','Prime Minister'),
(1987, 'Chemistry','Donald J. Cram','USA','Scientist'),
(1987, 'Chemistry','Jean-Marie Lehn','France','Scientist'),
(1987, 'Physiology','Susumu Tonegawa','Japan','Scientist'),
(1994, 'Economics','Reinhard Selten','Germany','Economist'),
(1994, 'Peace','Yitzhak Rabin','Israel','Prime Minister'),
(1987, 'Physics','Johannes Georg Bednorz','Germany','Scientist'),
(1987, 'Literature','Joseph Brodsky','Russia','Linguist'),
(1987, 'Economics','Robert Solow','USA','Economist'),
(1994, 'Literature','Kenzaburo Oe','Japan','Linguist')




/*
12. write a SQL query to find the Nobel Prize winner(s) for the year 1970. Return year, subject and winner. 
*/


SELECT 
	YEAR,
	SUBJECT,
	WINNER

FROM nobel_win
WHERE YEAR = 1970


/*
 write a SQL query to find the Nobel Prize winner in ‘Literature’ for 1971. Return winner. 
*/

SELECT
	WINNER
FROM nobel_win
WHERE SUBJECT = 'Literature' and
	  YEAR = 1971

/*
14. write a SQL query to locate the Nobel Prize winner ‘Dennis Gabor'. Return year, subject.
*/

SELECT
	YEAR,
	SUBJECT
FROM nobel_win
WHERE WINNER = 'Dennis Gabor'


/*
15. write a SQL query to find the Nobel Prize winners in the field of ‘Physics’ since 1950. Return winner. 
*/

SELECT
	WINNER
FROM nobel_win
WHERE SUBJECT ='Physics' AND
	 YEAR >= 1950


/*
16. write a SQL query to find the Nobel Prize winners in ‘Chemistry’ between the years 1965 and 1975.
    Begin and end values are included. Return year, subject, winner, and country.  
*/


SELECT
	YEAR,
	SUBJECT,
	WINNER,
	COUNTRY
FROM nobel_win
WHERE SUBJECT = 'Chemistry' AND
	  YEAR BETWEEN 1965 AND  1975

/*
SELECT year, subject, winner, country
  FROM nobel_win
 WHERE subject = 'Chemistry'
   AND year>=1965 AND year<=1975;
*/


/*
17. Write a SQL query to display all details of the Prime Ministerial winners after 1972 of Menachem Begin and Yitzhak Rabin. 
*/


SELECT
*
,,ROM nobel_win+
WHERE YEAR > 1972 AND
	  WINNER IN ('Menachem Begin', 'Yitzhak Rabin')


/*
18. From the following table, write a SQL query to retrieve the details of the winners whose first names match with the string ‘Louis’.
    Return year, subject, winner, country, and category. 
*/

SELECT
  *
FROM nobel_win
WHERE WINNER LIKE 'Louis %'

/*
19. write a SQL query that combines the winners in Physics, 1970 and in Economics, 1971. Return year, subject, winner, country, and category. 
*/


SELECT
	*
FROM nobel_win
WHERE (SUBJECT = 'Physics' AND YEAR =1970)
UNION
(SELECT
	*
FROM nobel_win
WHERE (SUBJECT = 'Economics' AND YEAR = 1971)
)


/*
20. write a SQL query to find the Nobel Prize winners in 1970 excluding the subjects of Physiology and Economics.
    Return year, subject, winner, country, and category.
*/

SELECT 
	*
FROM nobel_win
WHERE YEAR = 1970
AND   SUBJECT IN ('Physiology','Economics')


/*
22. write a SQL query to find the details of the Nobel Prize winner 'Johannes Georg Bednorz'. 
    Return year, subject, winner, country, and category.
*/

SELECT
*
FROM nobel_win
WHERE WINNER = 'Johannes Georg Bednorz'


/*
23. write a SQL query to find Nobel Prize winners for the subject that does not begin with the letter 'P'. 
    Return year, subject, winner, country, and category. Order the result by year, descending and winner in ascending.
*/

SELECT
*
FROM nobel_win
WHERE SUBJECT NOT LIKE 'P%' 
ORDER BY YEAR DESC, WINNER ASC


/*
24.write a SQL query to find the details of 1970 Nobel Prize winners. 
   Order the results by subject, ascending except for 'Chemistry' and ‘Economics’ which will come at the end of the result set. 
   Return year, subject, winner, country, and category.
*/

SELECT
*
FROM nobel_win
WHERE YEAR =1970
ORDER BY 
		CASE
			WHEN SUBJECT IN ('Chemistry','Economics') THEN 1
		ELSE 0
		END ASC,
SUBJECT,WINNER


---------CREATE item_mast TABLE----------------------

CREATE TABLE item_mast(
PRO_ID INT Primary key,
PRO_NAME varchar (20) not null,                      
PRO_PRICE float (20) not null,   
PRO_COM int 
)

----Insert Data Into The Talble------

INSERT INTO item_mast VALUES    (101, 'Mother Board',3200.00,15),
								(102, 'Key Board',450.00,16),
								(103, 'ZIP drive',250.00,14),
								(104, 'Speaker',550.00,16),
								(105, 'Monitor',5000.00,11),
								(106, 'DVD drive',900.00,12),
								(107, 'CD drive',800.00,12),
								(108, 'Printer',2600.00,13),
								(109, 'Refill cartridge',350.00,13),
								(110, 'Mouse',250.00,12)

---------CREATE EMPLOYEE DETAILS TABLE----------------------

CREATE TABLE emp_details(
EMP_IDNO int Primary Key,
EMP_FNAME varchar (15) not null,
EMP_LNAME varchar (15) not null,
EMP_DEPT int not null 
)

--INSERT DATE INTO THE TABLE---

INSERT INTO emp_details VALUES (127323,'Michale','Robbin', 57),
							   (526689,'Carlos','Snares',63),
							   (843795,'Enric','Dosio',57),
							   (328717, 'Jhon','Snares',63),
							   (444527, 'Joseph','Dosni',47),
							   (659831, 'Zanifer','Emily',47),
							   (847674,'Kuleswar','Sitaraman',57),
							   (748681, 'Henrey','Gabriel',47),
							   (555935, 'Alex','Manuel',57),
							   (539569, 'George','Mardy',27),
							   (733843, 'Mario','Saule',63),
							   (631548, 'Alan','Snappy',27),
							   (839139, 'Maria','Foster',57)


SELECT* FROM emp_details
SELECT* FROM item_mast



/*
25. write a SQL query to select a range of products whose price is in the range Rs.200 to Rs.600. 
   Begin and end values are included. Return pro_id, pro_name, pro_price, and pro_com.  
*/

SELECT
	*
from item_mast
WHERE PRO_PRICE BETWEEN 200 AND 600

/*
26. write a SQL query to calculate the average price for a manufacturer code of 16. Return avg. 
*/

SELECT
	AVG(PRO_PRICE) AS abg_price
FROM item_mast
WHERE PRO_COM = 16


/*
27. write a SQL query to display the pro_name as 'Item Name' and pro_priceas 'Price in Rs.' 
*/

SELECT
	PRO_NAME AS Item_Name,
	PRO_PRICE AS Price_in_Rs
FROM item_mast


/*
28.write a SQL query to find the items whose prices are higher than or equal to $250.
   Order the result by product price in descending, then product name in ascending.
   Return pro_name and pro_price.   
*/


SELECT
    PRO_NAME as Product_Name,
	PRO_PRICE AS Product_Price
FROM item_mast
WHERE PRO_PRICE >= 250
ORDER BY PRO_PRICE DESC, PRO_NAME ASC


/*
29. write a SQL query to calculate average price of the items for each company. Return average price and company code.
*/

SELECT
	PRO_COM,
	AVG(PRO_PRICE) AS avg_items_parice
FROM item_mast
GROUP BY PRO_COM


/*
30. write a SQL query to find the cheapest item(s). Return pro_name and, pro_price.
*/

SELECT
	PRO_NAME AS Product_name,
	PRO_PRICE AS Cheapest_items
FROM item_mast
WHERE PRO_PRICE = (SELECT MIN(PRO_PRICE) FROM item_mast)


/*
31. write a SQL query to find the unique last name of all employees. Return emp_lname.  
*/

SELECT
	DISTINCT(EMP_LNAME)
FROM emp_details


/*
32. write a SQL query to find the details of employees whose last name is 'Snares'. 
    Return emp_idno, emp_fname, emp_lname, and emp_dept.
*/

SELECT
 *
FROM emp_details
WHERE EMP_LNAME LIKE 'Snares'
-- EMP_NAME = 'Snares'


/*
33. write a SQL query to retrieve the details of the employees who work in the department 57.
   Return emp_idno, emp_fname, emp_lname and emp_dept.
*/

SELECT 
	*
FROM emp_details
WHERE EMP_DEPT = 57