
								-- Problems on StrataScratch --

/*
We have a table with employees and their salaries, however, some of the records are old and contain outdated salary information. 
Find the current salary of each employee assuming that salaries increase each year. Output their id, first name, last name, department ID, 
and current salary. Order your list by employee ID in ascending order.

Table: ms_employee_salary
*/

select 
	id,first_name,last_name,department_id,
	max(salary) as current_salary
from ms_employee_salary
group by 
	id,first_name,last_name,department_id
order by 
	id ;



/*

Number of Shipments Per Month

Write a query that will calculate the number of shipments per month. The unique key for one shipment is a combination of shipment_id and sub_id.
Output the year_month in format YYYY-MM and the number of shipments in that month.
Table: amazon_shipment
*/

	select  
		(CONVERT (varchar(7), shipment_date, 126)) as year_month,
		 count(DISTINCT CONCAT(shipment_id,' ',sub_id)) as total_shipments
	from 
		amazon_shipment
	group by 
		(CONVERT (varchar(7), shipment_date, 126))
	

		---second method---

	
	select  
		format(cast(shipment_date as date),'yyyy-MMM') as year_month,
		 count(DISTINCT CONCAT(shipment_id,' ',sub_id)) as total_shipments
	from 
		amazon_shipment
	group by 
		format(cast(shipment_date as date),'yyyy-MMM')
	
		----thired method---

	select  
		format(CONVERT(DATE,shipment_date),'yyyy-MMM') as year_month,
		 count(DISTINCT CONCAT(shipment_id,' ',sub_id)) as total_shipments
	from 
		amazon_shipment
	group by 
		format(CONVERT(DATE,shipment_date),'yyyy-MMM')
	

/*
		Salaries Differences

Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. 
Output just the absolute difference in salaries.

Tables: db_employee, db_dept
*/
 
 --CASE FUNCTION--

	SELECT ABS(

	MAX(CASE WHEN department = 'engineering' THEN salary END) - MAX(CASE WHEN department = 'marketing' THEN salary END) 
	)  AS max_salary_diff

	FROM db_employee e
	INNER JOIN db_dept d ON e.department_id = d.id

---CTE--
	
	WITH CTE AS (
		SELECT
		d.department,
		MAX(salary) AS max_salary
		FROM db_employee e
		JOIN db_dept d ON e.department_id = d.id
		WHERE d.department in ('engineering','marketing')
		GROUP BY d.department)
    
	SELECT MAX(max_salary) - MIN(max_salary) FROM CTE


-- SUBQUARY --

	SELECT 
		ABS((SELECT MAX(salary) 
		 FROM db_employee e JOIN db_dept d
			ON e.department_id = d.id
			WHERE  department = 'engineering')
			- 
		(SELECT MAX(salary) 
		 FROM db_employee e JOIN db_dept d
			ON e.department_id = d.id
		 WHERE  department = 'marketing'
		)) AS Salary_Diffrance
    
	--------------
    
    SELECT
       ABS((SELECT MAX(salary)
       FROM db_employee
       WHERE department_id=
					(SELECT id FROM db_dept WHERE department = 'engineering'))
       -
       (SELECT MAX(salary)
       FROM db_employee
       WHERE department_id=
					(SELECT id FROM db_dept WHERE department = 'marketing'))) AS Salary_Diff



/*
				Unique Users Per Client Per Month

Write a query that returns the number of unique users per client per month

Table: fact_events
*/

select
    client_id,
    MONTH(time_id) as year_month,
    COUNT(distinct(user_id) )AS Total_Unique_User
from fact_events
group by MONTH(time_id),
			   client_id;



/*
				Find all posts which were reacted to with a heart

Find all posts which were reacted to with a heart. For such posts output all columns from facebook_posts table.

Tables: facebook_reactions, facebook_posts
*/


	select 
		distinct(p.post_id),
		p.poster,
		p.post_text,
		p.post_keywords,
		p.post_date
	from facebook_reactions r join facebook_posts p
		on r.post_id = p.post_id
	where r.reaction = 'heart';
	
	---subquery---


	select
	*
	from facebook_posts
	where post_id in (select post_id from facebook_reactions
					  where reaction = 'heart')


/*
			Popularity of Hack

Meta/Facebook has developed a new programing language called Hack.To measure the popularity of Hack they ran a survey with their employees.
The survey included data on previous programing familiarity as well as the number of years of experience, age, gender and most importantly satisfaction with Hack. 
Due to an error location data was not collected, but your supervisor demands a report showing average popularity of Hack by office location.
Luckily the user IDs of employees completing the surveys were stored.

Based on the above, find the average popularity of the Hack per office location.
Output the location along with the average popularity.

Tables: facebook_employees, facebook_hack_survey
*/


	select 
		location,
		avg(cast(popularity as float)) as avg_popularity
		--round(avg(cast(popularity as decimal(2,1))),2) as avg_popularity
	from facebook_employees e join facebook_hack_survey s 
		on e.id = s.employee_id
	group by 
		e.location

    --using Window functions
 
    select 
        distinct(location),
        avg(cast(popularity as float)) over (partition by location) as avg_popularity
    from facebook_employees e join facebook_hack_survey s 
    on e.id = s.employee_id
    
    
 /*
			Find how many times each artist appeared on the Spotify ranking list

Find how many times each artist appeared on the Spotify ranking list
Output the artist name along with the corresponding number of occurrences.
Order records by the number of occurrences in descending order.

Table: spotify_worldwide_daily_song_ranking
*/

		select 
			artist,
			count(position) as number_of_occurrences
		from spotify_worldwide_daily_song_ranking
		group by 
			artist
		order by 
			number_of_occurrences desc;


/*
			Find the base pay for Police Captains

Output the employee name along with the corresponding base pay.


Table: sf_public_salaries
*/


	select 
		employeename,
		basepay
	from sf_public_salaries
	where 
		jobtitle = 'CAPTAIN III (POLICE DEPARTMENT)';


/*
Find libraries who haven't provided the email address in circulation year 2016 but their notice preference definition is set to email.
Output the library code.

Table: library_usage
*/

	select 
	   distinct( home_library_code)
	from library_usage
	where notice_preference_definition = 'email'
		 and   provided_email_address = 'FALSE'
		 and   circulation_active_year = 2016
	order by 
		home_library_code 
	;

/*
		Average Salaries

Compare each employee's salary with the average salary of the corresponding department.
Output the department, first name, and salary of employees along with the average salary of that department.

Table: employee
*/


	select 
		department,
		first_name,
		salary,
		avg(cast(salary as float)) over (partition by department) as Average_Salary
	from employee;



/*
		Order Details

Find order details made by Jill and Eva.
Consider the Jill and Eva as first names of customers.
Output the order date, details and cost along with the first name.
Order records based on the customer id in ascending order.

Tables: customers, orders
*/

	select
		s.first_name,
		o.order_date,
		o.order_details,
		total_order_cost
	from customers  s join orders o 
		on s.id = o.cust_id
	where first_name in ('Jill','Eva')
	order by
		s.id asc ;
    
/*
		Lyft Driver Wages

Find all Lyft drivers who earn either equal to or less than 30k USD or equal to or more than 70k USD.
Output all details related to retrieved records.

Table: lyft_drivers
*/

	
	select
	*
	from lyft_drivers
	where yearly_salary <= '30000'
	or  yearly_salary >= '70000'


/*
			Customer Details

Find the details of each customer regardless of whether the customer made an order. Output the customer's first name, last name, and the city along with the order details.
You may have duplicate rows in your results due to a customer ordering several of the same items. Sort records based on the customer's first name and the order details in ascending order.

Tables: customers, orders
*/

	select 
	   c.first_name,
		c.last_name,
		c.city,
		o.order_details
	from customers c left join orders o
		on c.id = o.cust_id
	order by
	 c.first_name, o.order_details;


/*
		Number of Workers by Department Starting in April or Later

Find the number of workers by department who joined in or after April.
Output the department name along with the corresponding number of workers.
Sort records based on the number of workers in descending order.

Table: worker
*/

	select
		department,
		count(worker_id) as Total_Workers
	from worker
	where joining_date > '2014-04-01'
	group by 
		department
	order by
		Total_Workers desc;


/*
		Admin Department Employees Beginning in April or Later

Find the number of employees working in the Admin department that joined in April or later.

Table: worker
*/

	select 
		count(worker_id) as Total_Workers
	from worker
	where department = 'Admin'
	  and MONTH(joining_date) >= 4
	group by    
		department
	;


/*
		Churro Activity Date

Find the activity date and the pe_description of facilities with the name 'STREET CHURROS' and with a score of less than 95 points.

Table: los_angeles_restaurant_health_inspections
*/

	select
		activity_date,
		pe_description
	from los_angeles_restaurant_health_inspections
	where facility_name = 'STREET CHURROS'
	and   score < 95;


/*
	Find the most profitable company in the financial sector of the entire world along with its continent

Find the most profitable company from the financial sector. Output the result along with the continent.

Table: forbes_global_2010_2014
*/

	
	select 
		company,
		continent
	from forbes_global_2010_2014
	where sector = 'Financials' 
	and   profits = (select max(profits)as profitable from forbes_global_2010_2014)

--- Second Method

	select 
		top 1
		company,
		continent
	from forbes_global_2010_2014
	where sector = 'Financials'
	order by 
		profits desc

---Thired Method

	select 
		top 1
		company,
		continent
	from (select  company,continent,max(profits)as profitable from forbes_global_2010_2014
		  where sector = 'Financials'
		  group by continent,company ) as temp
	order by 
		temp.profitable desc

/*
		Count the number of user events performed by MacBookPro users

Count the number of user events performed by MacBookPro users.
Output the result along with the event name.
Sort the result based on the event count in the descending order.

Table: playbook_events
*/

	select 
		event_name,
		count(user_id) as Total_Events
	from playbook_events
	where device = 'macbook pro'
	group by    
		event_name
	order by 
		Total_Events desc;


/*
		Number Of Bathrooms And Bedrooms

Find the average number of bathrooms and bedrooms for each city’s property types.
Output the result along with the city name and the property type.

Table: airbnb_search_details
*/

	select
		city,
		property_type,
		avg(cast(bathrooms as float)) as Average_Bathrooms,
		avg(cast(bedrooms as float)) as Average_Bedrooms
	from airbnb_search_details
	group by    
		city,property_type;


/*
		Most Lucrative Products

You have been asked to find the 5 most lucrative products in terms of total revenue for the first half of 2022 
(from January to June inclusive).Output their IDs and the total revenue.

Table: online_orders
*/

	select 
		top 5
	   product_id,
	   sum(cost_in_dollars*units_sold) as profitable_products
	from 
		online_orders
	where 
		 MONTH(date) <= 6 
						-- we can also run these two date format   
		--date between '2022-01-01' and '2022-06-30'
		--datepart(MM,date) between 1 and 6 */
	group by
		product_id
	order by 
		profitable_products desc