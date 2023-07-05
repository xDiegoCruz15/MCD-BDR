# Tarea 9


## Correlacion de Pearson
La correlación de Pearson es una medida estadística que evalúa la relación lineal entre dos variables continuas. Es una medida de la fuerza y la dirección de la asociación entre las dos variables. La correlación de Pearson toma valores en el rango de -1 a 1.


```sql


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

```


## Explicacion del codigo

El procedimiento almacenado, denominado PEARSON_R_PROCEDURE, acepta cuatro parámetros:

table_name: El nombre de la tabla que contiene los datos a analizar.
column1_name y column2_name: Los nombres de las dos columnas de la tabla a las que se desea calcular la correlación.
PEARSON_R: Un parámetro de salida para almacenar el resultado del cálculo del coeficiente.
El procedimiento sigue estos pasos:

Inicialización de Variables: Se inicializan varias variables para almacenar los resultados intermedios de las operaciones de sumar y contar.

Ejecución de Consultas SQL Dinámicas: Se ejecutan una serie de consultas SQL, para calcular las sumas de las columnas individuales (SUM_X, SUM_Y), la suma de los productos de las columnas (SUM_XY), las sumas de los cuadrados de cada columna (SUM_XX, SUM_YY) y el número total de registros (CNT).

Cálculo del Coeficiente de Correlación: Se utiliza la fórmula del coeficiente de correlación de Pearson para calcular el resultado final que se almacena en PEARSON_R.


<br>
<br>



## Calculo distancia de Levenshtein

La distancia de Levenshtein. La distancia de Levenshtein, también conocida como edición de distancia, es una métrica que mide la diferencia entre dos cadenas de texto. El valor retornado es el número mínimo de ediciones de un solo carácter (inserciones, eliminaciones o sustituciones) requeridas para cambiar una cadena en la otra.




```sql

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
LEVENSHTEIN('prueba texto','ejemplo cadena');
```



## Explicación del código

s1 y s2: Son los dos parámetros de entrada para la función. Representan las dos cadenas de texto.

s1_len y s2_len: Representan las longitudes de s1 y s2 respectivamente.

i y j: Son los contadores de los ciclos que se utilizan para iterar a través de los caracteres de s1 y s2.

a, b, y c: Son variables temporales que se utilizan durante el cálculo de la distancia de Levenshtein. 

- a costo de eliminar un carácter (que es la distancia de Levenshtein calculada hasta el carácter anterior) valor actual en la matriz cv1,
- b  representa el costo de insertar un carácter (que es la distancia de Levenshtein calculada hasta el carácter actual más uno)
- c se utiliza para calcular el costo mínimo de edición (inserción, eliminación o sustitución).

cv0 y cv1: Son matrices para almacenar los valores temporales de la distancia de Levenshtein  cv1 almacena la matriz de la iteración actual, y cv0 almacena la matriz de la iteración anterior. 

<br>


El código se divide en una serie de pasos:

1. Inicialmente, el código verifica si las dos cadenas de entrada son iguales, si lo son, la función devuelve 0.

2. Luego, verifica si alguna de las cadenas está vacía, si una de ellas lo está, devuelve la longitud de la otra cadena como la distancia de Levenshtein.

3. Después de las verificaciones iniciales, la función comienza a calcular la distancia de Levenshtein. Para ello, crea dos matrices (cv0 y cv1) para almacenar los valores temporales de la distancia de Levenshtein.

4. Luego, el código entra en un ciclo, iterando a través de cada carácter de las dos cadenas. Para cada par de caracteres, calcula el costo de edición. Si los dos caracteres son iguales, el costo es 0, de lo contrario, se calcula el costo como el mínimo entre eliminar, insertar y sustituir un carácter. En espesifico este es uno de los pasos más importantes en el algoritmo de Levenshtein. a continuación se muestra el código que calcula el costo de edición:

```sql
SET c = IF(SUBSTRING(s1, i, 1) = SUBSTRING(s2, j, 1), a,
      LEAST(a, b, ORD(SUBSTRING(cv1, j+1, 1)))+1);



/* En esta línea, se verifica si el i-ésimo carácter de s1 es igual al j-ésimo carácter de s2. Si son iguales, no se requiere ninguna edición, por lo que el costo es a, que es la distancia de Levenshtein calculada hasta ahora.

Si no son iguales, se necesita una edición, ya sea una inserción, eliminación o sustitución. En ese caso, se calcula el costo mínimo de estas operaciones y se suma 1.

Aquí, a representa el costo de eliminar un carácter (que es la distancia de Levenshtein calculada hasta el carácter anterior), b representa el costo de insertar un carácter (que es la distancia de Levenshtein calculada hasta el carácter actual más uno), y ORD(SUBSTRING(cv1, j+1, 1))+1 representa el costo de sustituir un carácter (que es la distancia de Levenshtein calculada hasta el carácter siguiente más uno).

La función LEAST(a, b, ORD(SUBSTRING(cv1, j+1, 1)))+1 selecciona el costo mínimo de estas operaciones y suma 1 para reflejar la edición realizada. */

```

5. Al final del bucle, cv0 se copia a cv1, y la variable 'i' se incrementa.

6. Finalmente, una vez que se han procesado todas las letras, la función devuelve la distancia de Levenshtein como el último valor de la matriz cv1, que es el número mínimo de ediciones necesarias para cambiar una cadena por la otra.

