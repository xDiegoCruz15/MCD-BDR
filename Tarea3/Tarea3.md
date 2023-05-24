# Tarea 3


## Esquema modelo relacional

Se utilizó la estructura de la información ya presentada en la base de datos seleccionada 


1. Customer(<u> customer_id </u>,customer_unique_id,customer_zip_code_prefix,customer_city,customer_state)

2. Orders(<u>order_id</u>,customer_id,order_status,order_purchase_timestamp,order_approved_at,order_delivered_carrier_date,order_delivered_customer_date,order_estimated_delivery_date)

3. Order_items(<u>order_id</u>,<u>order_item_id</u>,product_id,seller_id,shipping_limit_date,price,freight_value)

4. Products(<u>product_id</u>,product_category_name,product_name_lenght,product_description_lenght,product_photos_qty,product_weight_g,product_length_cm,product_height_cm,product_width_cm)

5. Sellers(<u>seller_id</u>,seller_zip_code_prefix,seller_city,seller_state)

6. Payments(<u>order_id</u>,<u>payment_sequential</u>,payment_type,payment_installments,payment_value)

7. Order_reviews(<u>order_id</u>,<u>review_id</u>,review_score,review_comment_title,review_comment_message,review_creation_date,review_answer_timestamp)

8. Geolocation(<u>geolocation_zip_code</u>,<u>geolocation_city</u>,<u>geolocation_state</u>,geolocation_lat,geolocation_lng,geolocation_count)

9.  Product_category_translation(<u>product_category_name</u>,product_category_name_english)


<br>

## Calves Foráneas

* Uno a Uno <br> N/A

* Uno a Muchos <br>
1. Orders y Order_reviews <br>
1. Orders y Order_items <br>
1. Orders y Order_payments <br>
1. Orders y Customers <br>
1. Product y Order_items <br>
1. Product y Producto_translation <br>
1. Sellers y Geolocation <br>

* Muchos a Muchos <br>
1. Sellers y Order_items <br>
1. Customers y Geolocation <br>



## Diagrama de Entidad Relacion

<br>
<br>


![Diagrama](https://github.com/xDiegoCruz15/MCD-BDR/blob/master/Tarea3/Imagenes/Diagrama.jpg?raw=true)

<br>
<br>

## Operaciones de Algebra Relacional

<br>

### 1. Listado de productos adquiridos por 1 cliente especifico
<br>
Paso 1: Filtrar la tabla Customer con el atributo customer_unique_id = "x" <br>
Paso 2: Hacer un join con la tabla ordenes mediante el atributo  customer_id <br>
Paso 3: Hacer un join con la tabla Order_items mediante el atributo  Order_id 

Paso 4: proyectar los atributos deseados 




_T1 = σ<sub>(customer_unique_id = "x" )</sub>(Customers )_


_T2 = σ<sub>( T1.customer_id = Orders.customer_id )</sub>(T1 X Orders)_



_T3 = σ<sub>( T2.order_id = Order_items.order_id )</sub>(T2 X Order_items)_

π<sub>(customer_id,customer_unique_id,product_id)</sub>(T3)

<br>


### 2. Listado de productos vendidos por cada vendedor  <br>

Se realiza un join entre las tablas Sellers y Order_items mediante el atributo seller_id, posteriormente se proyectan los atributos deseados.

_π(<sub>seller_id,product_id</sub>)(σ<sub>( Sellers.seller_id = Order_items.seller_id )</sub>(Sellers X Order_items))_

<br>

### 3. Listado de productos vendidos por cada vendedor en un rango de fechas especifico  <br>

<br>

Se realiza un join entre las tablas Sellers y Order_items mediante el atributo seller_id, posteriormente se filtra la tabla resultante con el atributo shipping_limit_date en un rango de fechas especifico, finalmente se proyectan los atributos deseados.

_T1= σ<sub>( Sellers.seller_id = Order_items.seller_id )</sub>(Sellers X Order_items)_

_π(<sub>seller_id,product_id</sub>)( σ<sub>( T1.shipping_limit_date >= "x" and T1.shipping_limit_date <= "y" )</sub>(T1) )_

<br>

### 4. Listado de clientes que han realizado una review

<br>

Se realiza un join entre las tablas Customers y Orders mediante el atributo customer_id, posteriormente se realiza un join con la tabla Orders_reviews usando el atributo order_id y se proyectan los atributos deseados.

_T1 = σ<sub>( Customers.customer_id = Orders.customer_id )</sub>(Customers X Orders)_


_π(<sub>customer_unique_id</sub>)(σ<sub>( T1.order_id = Orders_review.order_id )</sub> (T1 X Orders_review))_

