DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forme_in_negozio`()
BEGIN
    SELECT box_forma.forma_stagionatura  
    FROM box_forma 
    LEFT JOIN box_forme_vendute on box_forme_vendute.id_forma = box_forma.id_forma
    WHERE add_months_to_timestamp(box_forma.forma_start_produzione, box_forma.forma_stagionatura) <= CURRENT_TIMESTAMP();
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forme_in_negozio_by_caseificio`(IN `caseificio_code` VARCHAR(64))
BEGIN
    SELECT box_forma.forma_stagionatura  
    FROM box_forma 
    LEFT JOIN box_forme_vendute on box_forme_vendute.id_forma = box_forma.id_forma
    WHERE box_forme_vendute.id_forma IS NULL AND box_forma.forma_code LIKE CONCAT (caseificio_code,'-%') AND add_months_to_timestamp(box_forma.forma_start_produzione, box_forma.forma_stagionatura) <= CURRENT_TIMESTAMP();
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forme_in_prodotte`()
BEGIN
    SELECT COUNT(*)  
    FROM box_forma;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forme_in_prodotte_by_caseificio`(IN `caseificio_code` VARCHAR(64))
BEGIN
    SELECT COUNT(*)  
    FROM box_forma 
    WHERE box_forma.forma_code LIKE CONCAT (caseificio_code,'-%');
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forme_in_prodotte_by_caseificio_and_range`(IN `start_date` DATE, IN `end_date` DATE, IN `caseificio_code` VARCHAR(64))
BEGIN
    SELECT COUNT(*)  
    FROM box_forma 
    WHERE box_forma.forma_code LIKE CONCAT (caseificio_code,'-%') AND box_forma.forma_start_produzione BETWEEN start_date AND end_date;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forme_in_prodotte_by_range`(IN `start_date` DATE, IN `end_date` DATE)
BEGIN
    SELECT COUNT(*)  
    FROM box_forma 
    WHERE box_forma.forma_start_produzione BETWEEN start_date AND end_date;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forme_in_stagionatura`()
BEGIN
    SELECT box_forma.forma_stagionatura  
    FROM box_forma 
    WHERE add_months_to_timestamp(box_forma.forma_start_produzione, box_forma.forma_stagionatura) > CURRENT_TIMESTAMP();
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forme_in_stagionatura_by_caseificio`(IN `caseificio_code` VARCHAR(64))
BEGIN
    SELECT box_forma.forma_stagionatura  
    FROM box_forma 
    WHERE box_forma.forma_code LIKE CONCAT (caseificio_code,'-%') and add_months_to_timestamp(box_forma.forma_start_produzione, box_forma.forma_stagionatura) > CURRENT_TIMESTAMP();
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forme_vendute`()
BEGIN
    SELECT COUNT(*)  
    FROM box_forme_vendute;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forme_vendute_by_caseificio`(IN `caseificio_code` VARCHAR(64))
BEGIN
    SELECT COUNT(*)  
    FROM box_forme_vendute
    INNER JOIN box_forma on box_forma.id_forma = box_forme_vendute.forma_id and box_forma.forma_code LIKE CONCAT (caseificio_code,'-%');
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forme_vendute_by_caseificio_and_range`(IN `start_date` DATE, IN `end_date` DATE, IN `caseificio_code` VARCHAR(64))
BEGIN
    SELECT COUNT(*)  
    FROM box_forme_vendute
    inner JOIN box_forma on box_forma.id_forma = box_forme_vendute.forma_id
    WHERE box_forma.forma_code LIKE CONCAT (caseificio_code,'-%') AND box_forma.forma_start_produzione BETWEEN start_date AND end_date;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forme_vendute_by_range`(IN `start_date` DATE, IN `end_date` DATE)
BEGIN
    SELECT COUNT(*)  
    FROM box_forme_vendute 
    WHERE box_forme_vendute.forma_vendita BETWEEN start_date AND end_date;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_milk`()
BEGIN
    SELECT box_milk.milk_quantity, box_milk.milk_type 
    FROM box_milk ;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_milk_by_caseificio`(IN `caseificio_code` VARCHAR(255))
BEGIN
    SELECT box_milk.milk_quantity, box_milk.milk_type 
    FROM box_milk 
    INNER JOIN box_caseificio ON box_caseificio.id_caseificio = box_milk.id_caseificio 
    AND box_caseificio.code_caseificio = caseificio_code;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_milk_by_caseificio_and_range`(IN `start_date` DATE, IN `end_date` DATE, IN `caseificio_code` VARCHAR(255))
BEGIN
    SELECT box_milk.milk_quantity, box_milk.milk_type 
    FROM box_milk 
    INNER JOIN box_caseificio ON box_caseificio.id_caseificio = box_milk.id_caseificio 
    AND box_caseificio.code_caseificio = caseificio_code 
    WHERE milk_date BETWEEN start_date AND end_date;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_milk_by_range`(IN `start_date` DATE, IN `end_date` DATE)
BEGIN
    SELECT box_milk.milk_quantity, box_milk.milk_type 
    FROM box_milk 
    WHERE milk_date BETWEEN start_date AND end_date;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_by_credentials`(IN `login` VARCHAR(128), IN `password` VARCHAR(128))
BEGIN
  SELECT user_name, user_lastname, id_user, user_permission FROM box_user
  WHERE user_email = login AND user_psw = password;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_caseificio`(
    IN code_caseificio VARCHAR(256),
    IN name_caseificio VARCHAR(512),
    IN caseificio_street VARCHAR(256),
    IN caseificio_region VARCHAR(256)
)
BEGIN
    INSERT INTO box_caseificio (code_caseificio, name_caseificio, caseificio_street, caseificio_region)
    VALUES (code_caseificio, name_caseificio, caseificio_street, caseificio_region);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_forme`(IN `forma_scelta` VARCHAR(128), IN `forma_stagionatura` INT(11), IN `caseificio_code` INT(64), IN `num_executions` INT(11))
BEGIN
    DECLARE generated_code VARCHAR(64);
    DECLARE i INT DEFAULT 1;
    DECLARE inserted_records INT DEFAULT 0;
    WHILE i <= num_executions DO
        SET generated_code = get_code_forma(caseificio_code);
        INSERT INTO box_forma (forma_code, forma_scelta, forma_stagionatura) VALUES (generated_code, forma_scelta, forma_stagionatura);
        SET inserted_records = inserted_records + 1;
        SET i = i + 1;
    END WHILE;
    SELECT * FROM box_forma WHERE id_forma BETWEEN LAST_INSERT_ID() - inserted_records + 1 AND LAST_INSERT_ID();
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_milk`(IN `p_code_caseificio` VARCHAR(256), IN `p_milk_quantity` INT, IN `p_milk_type` VARCHAR(256))
BEGIN    
    INSERT INTO box_milk (id_milk, id_caseificio, milk_quantity, milk_type)
    SELECT NULL, c.id_caseificio, p_milk_quantity, p_milk_type
    FROM box_caseificio c
    WHERE c.code_caseificio = p_code_caseificio;
    
    SELECT *
    FROM box_milk
    WHERE id_milk >= LAST_INSERT_ID();
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_or_get_acquirente_id`(IN `p_acquirente_name` VARCHAR(256), IN `p_acquirente_iva` VARCHAR(256))
BEGIN
    DECLARE v_id_acquirente INT;
    
    SELECT id_acquirente INTO v_id_acquirente
    FROM box_acquirente
    WHERE acquirente_name = p_acquirente_name
    AND acquirente_iva = p_acquirente_iva;
    
    IF v_id_acquirente IS NULL THEN
        INSERT INTO box_acquirente (acquirente_name, acquirente_iva)
        VALUES (p_acquirente_name, p_acquirente_iva);
        
        SET v_id_acquirente = LAST_INSERT_ID();
    END IF;
    
    SELECT v_id_acquirente AS id_acquirente;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_user`(IN `firstname` VARCHAR(128), IN `lastname` VARCHAR(128), IN `email` VARCHAR(128), IN `psw` VARCHAR(128), IN `permission` VARCHAR(128))
BEGIN
    DECLARE uuid_val VARCHAR(64);

    SET uuid_val = (SELECT UUID());

    INSERT INTO `box_user` (
        `id_user`,
        `user_name`,
        `user_lastname`,
        `user_email`,
        `user_psw`,
        `user_permission`
    ) VALUES (
        uuid_val,
        firstname,
        lastname,
        email,
        psw,
        permission
    );
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_assets_by_caseificio_code`(IN `code` VARCHAR(256))
BEGIN
  SELECT ba.asset_src
  FROM box_assets ba
  INNER JOIN box_caseificio bc ON ba.id_caseificio = bc.id_caseificio
  WHERE bc.code_caseificio = code;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_caseifici`()
BEGIN
    SELECT * FROM box_caseificio;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_caseificio_by_code`(IN code VARCHAR(256))
BEGIN
    SELECT * FROM box_caseificio WHERE code_caseificio = code;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `select_user_by_uuid`(IN `uuid` VARCHAR(64))
BEGIN
  SELECT * FROM box_user WHERE id_user = uuid;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sell_forme`(IN `id_acquirente` INT, IN `forma_price_sell` FLOAT, IN `stagionatura` INT, IN `scelta` VARCHAR(128), IN `quantita` INT)
BEGIN DECLARE i INT DEFAULT 1;

DROP TEMPORARY TABLE IF EXISTS temp_box_forme_vendute;

CREATE TEMPORARY TABLE temp_box_forme_vendute (
  forma_id INT(11) NOT NULL,
  forma_price_sell FLOAT NOT NULL,
  forma_vendita TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  id_acquirente INT(11) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

WHILE i <= quantita DO
INSERT INTO
  box_forme_vendute (forma_id, forma_price_sell, id_acquirente)
SELECT
  f.id_forma,
  forma_price_sell,
  id_acquirente
FROM
  box_forma f
WHERE
  f.forma_stagionatura = stagionatura
  AND f.forma_scelta = scelta
  AND NOT EXISTS (
    SELECT
      1
    FROM
      box_forme_vendute vf
    WHERE
      vf.forma_id = f.id_forma
  )
LIMIT
  1;

SET
  @id_forma := LAST_INSERT_ID();

INSERT INTO
  temp_box_forme_vendute (forma_id, forma_price_sell, id_acquirente)
SELECT
  f.forma_id,
  forma_price_sell,
  id_acquirente
FROM
  box_forme_vendute f
WHERE
  f.id_forma = @id_forma;

SET
  i = i + 1;

END WHILE;

SELECT
  t.forma_price_sell,
  f.forma_code,
  f.forma_scelta,
  f.forma_stagionatura
FROM
  temp_box_forme_vendute t
  JOIN box_forma f ON t.forma_id = f.id_forma;

DROP TEMPORARY TABLE IF EXISTS temp_box_forme_vendute;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_caseificio_name_by_code`(IN `code` VARCHAR(256), IN `name` VARCHAR(512))
BEGIN
  UPDATE box_caseificio SET name_caseificio = name WHERE code_caseificio = code;
END$$
DELIMITER ;
