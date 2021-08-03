/* This sql file is being used to generate report for 
	"Total earned by driver for selected date range"*/


SELECT SUM(totalpayout) FROM driver_payout WHERE driver_id = 1 AND transact_time BETWEEN '2021-05-23' AND '2021-05-26';
