Select * from bank_loan_data

                                               --A.	BANK LOAN REPORT | SUMMARY--

														--KPI’s:
--Total Loan Applications
select count(id) Total_Loan_Applications
from [Bank Loan DB]..bank_loan_data

--MTD Loan Applications
select count(id) MTD_Total_Loan_Applications
from [Bank Loan DB]..bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

--PMTD Loan Applications
select count(id) PMTD_Total_Loan_Applications
from [Bank Loan DB]..bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021

--Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data

--MTD Total Funded Amount
select sum(loan_amount) as MTD_Total_Funded_Amount 
from [Bank Loan DB]..bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

--PMTD Total Funded Amount
select sum(loan_amount) as PMTD_Total_Funded_Amount 
from [Bank Loan DB]..bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021 

--Total Amount Received
select sum(total_payment) as Total_Amount_Received
from [Bank Loan DB]..bank_loan_data

--MTD Total Amount Received
select sum(total_payment) as MTD_Total_Amount_Received
from [Bank Loan DB]..bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

--PMTD Total Amount Received
select sum(total_payment) as PMTD_Total_Amount_Received
from [Bank Loan DB]..bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021 

--Average Interest Rate
select round(avg(int_rate),4)*100  as Avg_Interst_Rate 
from [Bank Loan DB]..bank_loan_data 

--MTD Average Interest
select round(avg(int_rate),4)*100  as MTD_Avg_Interst_Rate 
from [Bank Loan DB]..bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

--PMTD Average Interest
select round(avg(int_rate),4)*100  as MTD_Avg_Interst_Rate 
from [Bank Loan DB]..bank_loan_data

--Avg DTI
select round(avg(dti),4)*100  as Avg_DTI
from [Bank Loan DB]..bank_loan_data

--MTD Avg DTI
select round(avg(dti),4)*100 as MTD_Avg_DTI
from [Bank Loan DB]..bank_loan_data
where month(issue_date) =12 and year(issue_date) =2021

--PMTD Avg DTI
select round(avg(dti),4)*100 as PMTD_Avg_DTI
from [Bank Loan DB]..bank_loan_data
where month(issue_date) =11 and year(issue_date) =2021



														--GOOD LOAN ISSUED:
--Good Loan Percentage
select (count
	(case 
		when loan_status = 'Fully Paid' or loan_status = 'Current' 
			then id END)*100.0)
		/count(id) as Good_Loan_Percentage
from [Bank Loan DB]..bank_loan_data

--Good Loan Applications
select count(id) as Good_Loan_Applications
from [Bank Loan DB]..bank_loan_data
where loan_status = 'Fully Paid' or loan_status ='Current'

--Good Loan Funded Amount
select SUM(loan_amount) as Good_Loan_Funded_amount
from [Bank Loan DB]..bank_loan_data
where loan_status = 'Fully Paid' or loan_status ='Current'

--Good Loan Amount Received
select SUM(total_payment) as Good_Loan_Recived_amount
from [Bank Loan DB]..bank_loan_data
where loan_status = 'Fully Paid' or loan_status ='Current'



														--BAD LOAN ISSUED:
--Bad Loan Percentage
select(count
	(case when loan_status = 'Charged Off' then id end)*100.0)/
		count(id) AS Bad_Loan_Percentage
from [Bank Loan DB]..bank_loan_data

--Bad Loan Applications
select count(id) as Bad_Loan_Applications
from [Bank Loan DB]..bank_loan_data
where loan_status = 'Charged Off'

--Bad Loan Funded Amount
select sum(loan_amount) as Bad_Loan_amount_Funded
from [Bank Loan DB]..bank_loan_data
where loan_status = 'Charged Off'

--Bad Loan Amount Received
select sum(total_payment) as Bad_Loan_amount_Recived
from [Bank Loan DB]..bank_loan_data
where loan_status = 'Charged Off'


--1														--LOAN STATUS:
select  loan_status,
        COUNT(id) AS Total_Loan_applications,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
from [Bank Loan DB]..bank_loan_data
group by loan_status

--2
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
from [Bank Loan DB]..bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status

                                               --B.	BANK LOAN REPORT | OVERVIEW--

--MONTH
select	month(issue_date) as Month_Number,
		datename(month, issue_date) as Month_Name,
		count(id) as Total_Loan_Application,
		sum(Loan_amount) as Total_Funded_Amount,
		sum(total_payment) as Total_Receved_Amount
from [Bank Loan DB]..bank_loan_data
group by month(issue_date),datename(month, issue_date)
order by month(issue_date)

--STATE
select	address_state,
		count(id) as Total_Loan_Application,
		sum(Loan_amount) as Total_Funded_Amount,
		sum(total_payment) as Total_Receved_Amount
from [Bank Loan DB]..bank_loan_data
group by address_state
order by address_state

--TERM
select	term,
		count(id) as Total_Loan_Application,
		sum(Loan_amount) as Total_Funded_Amount,
		sum(total_payment) as Total_Receved_Amount
from [Bank Loan DB]..bank_loan_data
group by term
order by term 

--EMPLOYEE LENGTH
select	emp_length,
		count(id) as Total_Loan_Application,
		sum(Loan_amount) as Total_Funded_Amount,
		sum(total_payment) as Total_Receved_Amount
from [Bank Loan DB]..bank_loan_data
group by emp_length
order by count(id) desc

--PURPOSE
select	purpose AS Purpose,
		count(id) as Total_Loan_Application,
		sum(Loan_amount) as Total_Funded_Amount,
		sum(total_payment) as Total_Receved_Amount
from [Bank Loan DB]..bank_loan_data
group by purpose
order by count(id) desc 

--HOME OWNERSHIP
select	home_ownership,
		count(id) as Total_Loan_Application,
		sum(Loan_amount) as Total_Funded_Amount,
		sum(total_payment) as Total_Receved_Amount
from [Bank Loan DB]..bank_loan_data
group by home_ownership
order by count(id) desc 

