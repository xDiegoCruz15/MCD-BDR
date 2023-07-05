

DELIMITER //


DROP PROCEDURE IF EXISTS PEARSON_R_PROCEDURE //
CREATE PROCEDURE PEARSON_R_PROCEDURE(
    IN table_name VARCHAR(64), 
    IN column1_name VARCHAR(64), 
    IN column2_name VARCHAR(64),
    OUT PEARSON_R FLOAT
)
BEGIN 
    DECLARE SUM_X BIGINT DEFAULT 0;
    DECLARE SUM_Y BIGINT DEFAULT 0;
    DECLARE SUM_XY BIGINT DEFAULT 0; 
    DECLARE SUM_XX BIGINT DEFAULT 0;
    DECLARE SUM_YY BIGINT DEFAULT 0;
    DECLARE CNT INT DEFAULT 0;

    SET @sql = CONCAT('SELECT SUM(', column1_name, ') FROM ', table_name, ' INTO @result');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    SET SUM_X = @result;
    DEALLOCATE PREPARE stmt;

    SET @sql = CONCAT('SELECT SUM(', column2_name, ') FROM ', table_name, ' INTO @result');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    SET SUM_Y = @result;
    DEALLOCATE PREPARE stmt;

    SET @sql = CONCAT('SELECT SUM(', column1_name, ' * ', column2_name, ') FROM ', table_name, ' INTO @result');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    SET SUM_XY = @result;
    DEALLOCATE PREPARE stmt;

    SET @sql = CONCAT('SELECT SUM(', column1_name, ' * ', column1_name, ') FROM ', table_name, ' INTO @result');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    SET SUM_XX = @result;
    DEALLOCATE PREPARE stmt;

    SET @sql = CONCAT('SELECT SUM(', column2_name, ' * ', column2_name, ') FROM ', table_name, ' INTO @result');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    SET SUM_YY = @result;
    DEALLOCATE PREPARE stmt;

    SET @sql = CONCAT('SELECT COUNT(*) FROM ', table_name, ' INTO @result');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    SET CNT = @result;
    DEALLOCATE PREPARE stmt;

    SET PEARSON_R = (
        (CNT * SUM_XY - SUM_X * SUM_Y) / 
        (SQRT(CNT * SUM_XX - SUM_X * SUM_X) * SQRT(CNT * SUM_YY - SUM_Y * SUM_Y))
    );
END //


DELIMITER ;



 CALL PEARSON_R_PROCEDURE('order_payments', 'payment_value', 'payment_installments', @result);


 SELECT @result;





/* Funcion distancia de levenstein */
DELIMITER //



DROP FUNCTION IF EXISTS LEVENSHTEIN //


CREATE FUNCTION LEVENSHTEIN(s1 VARCHAR(255), s2 VARCHAR(255))
RETURNS INT
DETERMINISTIC
BEGIN
  -- Se declaran las variables que se usarán en la función.
  DECLARE s1_len, s2_len, i, j, a, b, c INT;
  DECLARE cv0, cv1 VARBINARY(256);

  SET s1_len = CHAR_LENGTH(s1), s2_len = CHAR_LENGTH(s2), cv1 = 0x00, j = 1, i = 1, c = 0;

  -- Se verifica si las cadenas son iguales. En ese caso, la distancia es 0.
  IF s1 = s2 THEN
    RETURN 0;
  
  -- Si la primera cadena es vacía, la distancia es la longitud de la segunda cadena.
  ELSEIF s1_len = 0 THEN
    RETURN s2_len;
  
  -- Si la segunda cadena es vacía, la distancia es la longitud de la primera cadena.
  ELSEIF s2_len = 0 THEN
    RETURN s1_len;
  
  --  si ninguna de las cadenas es vacía y son diferentes se calcula la distancia.
  ELSE
    -- inicializa la matriz cv1.
    WHILE j <= s2_len DO 
      SET cv1 = CONCAT(cv1, UNHEX(HEX(j))), j = j + 1;
    END WHILE;

    -- recorre los caracteres de la primera cadena.
    WHILE i <= s1_len DO
      SET c = i;
      SET cv0 = UNHEX(HEX(i)), j = 1;
      
      -- recorre los caracteres de la segunda cadena.
      WHILE j <= s2_len DO
        SET a = ORD(SUBSTRING(cv1, j, 1));
        SET b = c;
        
        -- Calcula el costo de la operación de edición.
        SET c = IF(SUBSTRING(s1, i, 1) = SUBSTRING(s2, j, 1), a,
          LEAST(a, b, ORD(SUBSTRING(cv1, j+1, 1)))+1);

        SET cv0 = CONCAT(cv0, UNHEX(HEX(c))), j = j + 1;
      END WHILE;

      -- La matriz cv1 se actualiza con los valores de cv0.
      SET cv1 = cv0, i = i + 1;
    END WHILE;
  END IF;
  
  -- Se devuelve el último valor de cv1, que es la distancia de Levenshtein.
  RETURN c;
END//

DELIMITER ;



SELECT
LEVENSHTEIN('prueba texto','ejemplo');