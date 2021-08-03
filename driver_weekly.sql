/* This sql file is being used to generate report for 
	"Weekly amount paid to driver   " */

SELECT WEEK(payout_time) weeks, SUM(totalpayout) FROM driver_payout GROUP BY WEEK(payout_time) ORDER BY payout_time;