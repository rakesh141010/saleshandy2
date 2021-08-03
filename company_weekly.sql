/* This sql file is being used to generate report for 
	"Weekly revenue for company including tax"*/

SELECT WEEK(transact_time) weeks, SUM(total_amount) FROM transaction_detail GROUP BY WEEK(transact_time) ORDER BY transact_time 

