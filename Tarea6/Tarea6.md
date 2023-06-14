# Tarea 6

<br>

## 1. ¿Cuántos productos tienen más de 100 ventas? (conteo)

<br>

```sql
SELECT COUNT(*) AS numero_filas
FROM (
  SELECT product_id, COUNT(product_id) AS repeticiones
  FROM order_items
  GROUP BY product_id
  HAVING COUNT(product_id) >= 100
)AS subquery;
```
<br>

## 2. ¿Cuál es el producto más vendido? (máximo)

<br>

```sql

SELECT MAX(max_orders) AS max_value
FROM (
  SELECT COUNT(customer_unique_id) AS max_orders
  FROM orders
  JOIN customers ON customers.customer_id = orders.customer_id
  GROUP BY customer_unique_id
) AS subquery;
```
<br>

## 3. ¿Cuál es el monto mas bajo del valor de un producto registrado? (mínimo)

<br>

```sql	
SELECT MIN(price) AS precio_minimo
FROM order_items;
```
<br>

## 4. Cuartiles del valor de los pagos efectuados (cuartiles)

<br>

```sql	
SET SESSION group_concat_max_len = @@max_allowed_packet;
SET @temp_rows = (SELECT GROUP_CONCAT(payment_value ORDER BY payment_value ASC SEPARATOR ',') FROM order_payments WHERE payment_value IS NOT NULL);
SET @temp_count = (SELECT COUNT(payment_value) FROM order_payments WHERE payment_value IS NOT NULL);


SELECT
  SUBSTRING_INDEX(SUBSTRING_INDEX(@temp_rows, ',', ROUND(@temp_count * 0.25 + 1)), ',', -1) AS q1,
  SUBSTRING_INDEX(SUBSTRING_INDEX(@temp_rows, ',', ROUND(@temp_count * 0.5 + 1)), ',', -1) AS mediana,
  SUBSTRING_INDEX(SUBSTRING_INDEX(@temp_rows, ',', ROUND(@temp_count * 0.75 + 1)), ',', -1) AS q3;

   
SET @temp_count := NULL;
SET @temp_rows := NULL;
```
<br>

## 5. ¿Cuál es el producto mas vendido? (moda)

<br>


```sql
SELECT product_id, COUNT(product_id) AS repeticiones
FROM order_items
GROUP BY product_id
HAVING COUNT(product_id) = (
    SELECT COUNT(product_id) AS repeticiones
    FROM order_items
    GROUP BY product_id
    ORDER BY repeticiones DESC
    LIMIT 1
);


```


<br>

## Hallazgos y Dificultades  

1. Existen diferentes maneras de calcular un mismo dato, por ejemplo, los valores maximos y minimos de una columna se pueden calcular con las funciones MAX() y MIN() o con la función ORDER BY y LIMIT 1.Personalmente estaba acostumbrado a usar la segunda alternativa pero en esta occasion para usar las funciones vistas en clase recurrie a las funciones MAX() y MIN().


2. El SGBD con el que me encuentro trabajando no cuenta con una funcion directa para el calculo de cuartiles como puede ser el caso de PostgreSQL, por lo que tuve que recurrir a una solución alternativa que consiste en ordenar los datos en una lista separada por comas y luego calcular los cuartiles de manera manual.

3. Al guardar los datos en un lista, el string era truncado debido a que la sesión no estaba configurada para guardar un string de gran tamaño con la función group_concat, por lo que tuve que recurrir al comando SET SESSION group_concat_max_len = @@max_allowed_packet; para poder guardar el string completo. 

4. En algunas consultas era primero necesario realizar una subconsulta para luego poder realizar la consulta principal, por lo que tuve que investigar como realizar subconsultas.