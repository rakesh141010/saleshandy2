
/* This sql file describe Databse design and its structure for online cab rental  */


CREATE DATABASE IF NOT EXISTS cab_rental;

USE cab_rental;

CREATE TABLE IF NOT EXISTS `transaction_detail` (
	`transaction_id` int(6) AUTO_INCREMENT NOT NULL PRIMARY KEY,
	`passenger_id` int(6) NOT NULL,
	`driver_id` int(6) NOT NULL,
	`fare_amount` int(8) NOT NULL,
	`tax_onfare` int(8) NOT NULL,
	`total_amount` int(8) NOT NULL,
	`pay_method` varchar(40) NOT NULL,
	`transact_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT `chk_paymethod` check(`pay_method` in ('wallet', 'Netbanking', 'Credit_card'))
	
);

DELIMITER //
CREATE TRIGGER transaction_t1 BEFORE INSERT ON transaction_detail 
FOR EACH ROW 
BEGIN
	SET NEW.tax_onfare = 0.18 * NEW.fare_amount;
	SET NEW.total_amount = NEW.fare_amount + NEW.tax_onfare;
END;
//
DELIMITER ;




/* in this table, coulumn driver_id and fare_amount` is not required, 
	bacause transaction_id is referencing the same value in transaction table,
	but it is included for submission purpose only.  */
CREATE TABLE IF NOT EXISTS `driver_payout` (
	`payout_id` int(6) AUTO_INCREMENT NOT NULL PRIMARY KEY,
	`transaction_id` int(6),
	`driver_id` int(6) NOT NULL,
	`fare_amount` int(8) NOT NULL,
	`deduction` int(8) NOT NULL,
	`totalpayout` int(8) NOT NULL,
	`payout_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (transaction_id) REFERENCES transaction_detail(transaction_id) 
);


DELIMITER //
CREATE TRIGGER driver_payout_t
BEFORE INSERT ON `driver_payout`
FOR EACH ROW
BEGIN
	DECLARE v1, v2 INT;
	SELECT driver_id INTO v1 FROM transaction_detail WHERE transaction_id = NEW.transaction_id;
	SELECT fare_amount INTO v2 FROM transaction_detail WHERE transaction_id = NEW.transaction_id;
	SET NEW.driver_id = v1;
	SET NEW.fare_amount = v2;
	SET NEW.deduction = 0.15 * NEW.fare_amount;
	SET NEW.totalpayout = NEW.fare_amount - NEW.deduction;
END;
//
DELIMITER ;