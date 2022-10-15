
-- checking available tables in databse
SELECT name from sqlite_master WHERE type= "table";

-- each TABLE
SELECT * from customer;
PRAGMA table_info(customer);

SELECT * from cust_services;

-- Information about customers(using customer table)
-- Gender details of customers:-
SELECT Gender, count(Gender) 
from customer 
group by Gender;
-- male 3555, female 3488

-- Partner, if they have
SELECT Partner,Dependents, count(Partner), count(Dependents) 
from customer 
group by Partner, Dependents;
-- Yes 3402, No 3641

-- Dependents if they have
SELECT Dependents, count(Dependents) 
from customer 
group by Dependents;
-- Yes 1627, No 5416

-- Inforamtion about customer Account_id
SELECT round(avg(Tenure),2) 
from cust_account;
-- 32.37
SELECT round(avg(MonthlyCharges),2) 
from cust_account;
-- 64.76
SELECT round(avg(TotalCharges),2) 
from cust_account;
-- 2279.73

-- how many customers paid:TotalCharges, more than avg(paid)

SELECT count(Account_id) no_of_customers
from cust_account
WHERE TotalCharges > ( 
SELECT avg(TotalCharges)
from cust_account);
-- 4922

-- Contract
SELECT * from cust_account;
SELECT Contract, count(Contract)
from cust_account
group by Contract;
--Month-to-month 3875  Majority(50%) of customers are pay month to month 
--One year	1473
--Two year	1695

-- Informartion about Churn
SELECT * from cust_churn;

SELECT Churn,count(Churn)
from cust_churn
group by Churn;
--No	5174
--Yes	1869

-- analyzing churn w.r.t other variables
SELECT * from cust_churn;

SELECT Churn, count(Churn)
from cust_churn
group by Churn;
-- No	5174
-- Yes	1869

-- churn in compare to Gender

SELECT Gender, Churn, count(Churn)
from Customer c inner join cust_churn ch
on c.CustomerID = ch.Id
group by Gender, Churn;
/* 
Female	No	2549   NO churn Male/Female ratio same
Female	Yes	939    Yes churn also same
Male	No	2625
Male	Yes	930
*/


SELECT Partner, Churn, count(Churn)
from Customer c inner join cust_churn ch
on c.CustomerID = ch.Id
group by Partner, Churn;
/* 
No	No	2441
No	Yes	1200   
Yes	No	2733
Yes	Yes	669   
1. customer without partner:
> are more
> has more churned    
*/


-- Analyze w.r.t cust_account details

SELECT Churn, round(avg(Tenure)), round(avg(MonthlyCharges),2),round(avg(TotalCharges),2)
from cust_churn ch inner join cust_account ca
on ch.Id = ca.Account_id
group by Churn;
/*
No	38.0	61.27	2549.91
Yes	18.0	74.44	1531.8
> customers with long tenure of paymt with the comopany 
have churned less
> customers with more TotalCharges has churned less.
> customers who left pay more charges monthly but less as TotalCharges
*/

-- relation Contract w.r.t Churn
SELECT Churn, Contract, count(Contract)
from cust_churn ch inner join cust_account ca
on ch.Id = ca.Account_id
group by Churn, Contract;
/*
No	Month-to-month	2220
No	One year	1307
No	Two year	1647
Yes	Month-to-month	1655
Yes	One year	166
Yes	Two year	48
> customer with long Contract(in Years) are less likely to churn
*/


