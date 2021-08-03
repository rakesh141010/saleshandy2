/* This sql file is being used to generate report for 
	"The total amount of transaction processed through CRedit card for selected date range"*/

SELECT SUM(total_amount) FROM transaction_detail WHERE pay_method = "Credit_card" AND transact_time BETWEEN '2021-05-23' AND '2021-05-26';