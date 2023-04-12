DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `add_months_to_timestamp`(ts TIMESTAMP, months INT) RETURNS timestamp
BEGIN
  RETURN DATE_ADD(ts, INTERVAL months MONTH);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_code_forma`(`code_casa` VARCHAR(64)) RETURNS varchar(64) CHARSET utf8
BEGIN
DECLARE current_year INT;
DECLARE current_month INT;
DECLARE current_count INT;
DECLARE generated_code VARCHAR(64);

SELECT YEAR(CURRENT_DATE()) INTO current_year;
SELECT MONTH(CURRENT_DATE()) INTO current_month;

SELECT COUNT(*) INTO current_count
FROM box_forma
WHERE YEAR(forma_start_produzione) = current_year AND MONTH(forma_start_produzione) = current_month;

IF current_count IS NULL THEN
SET current_count = 0;
END IF;

SET current_count = current_count + 1;

SET generated_code = CONCAT(LPAD(code_casa, 4, '0'),'-', current_year, '-', LPAD(current_month, 2, '0'), '-', LPAD(current_count, 4, '0'));

RETURN generated_code;
END$$
DELIMITER ;
