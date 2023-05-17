# Tarea 2

A continuación se presenta gráfico entidad relación de la base de datos Brazilian ecommerce.
<br>
<br>

```mermaid
graph LR

subgraph "Orders"
direction RL

    
    C[orders] --1---id37{order_id}

    G[orders_payments]
    G[orders_payments] ---id33([payment_sequential])
    G[orders_payments] ---id34([payment_type])
    G[orders_payments] ---id35([payment_installments])
    G[orders_payments] ---id36([payment_value])
     G[orders_payments] --N---id37{order_id}
   


    C[orders] ---id11([order_delivered_carrier_date])
    C[orders] ---id12([order_delivered_customer_date])
    C[orders] ---id13([order_estimated_delivery_date])
    C[orders] ---id8([order_status])
    C[orders] ---id9([order_purchase_timestamp])
    C[orders] ---id10([order_approved_at])
   
end
 

   
 
subgraph "Order Items"
    A[orders_items] ---id1([shipping_limit_date])
    A[orders_items] ---id2([price])
    A[orders_items] ---id3([freight_value])
    A[orders_items] ---id4([order_item_id])

    
    
end


subgraph "Sellers"
    B[sellers] ---id6([seller_city])
    B[sellers] ---id7([seller_state])
    A[orders_items] -- N --- id5{seller_id}
    B[seller] -- N --- id5{seller_id}

    
end






subgraph "Orders and Reviews"
    D -- N --- id21{order_id}
    D[orders_reviews] ---id15([review_id])
    D[orders_reviews] ---id16([review_score])
    D[orders_reviews] ---id17([review_comment_title])
    D[orders_reviews] ---id18([review_comment_message])
    D[orders_reviews] ---id19([review_creation_date])
    D[orders_reviews] ---id20([review_answer_timestamp])

    
  
end




subgraph "products"

    H[products] 
    H[products] ---id32([product_category_name])
    H[products] ---id38([product_name_lenght])
    H[products] ---id39([product_description_lenght])
    H[products] ---id40([product_photos_qty])
    H[products] ---id41([product_weight_g])
    H[products] ---id42([product_length_cm])
    H[products] ---id43([product_height_cm])
    H[products] ---id44([product_width_cm])
    
end

subgraph "product translations"
    I[product_translations]
    I[product_translations] ---id46([product_category_name_english])

    
end




subgraph "Customers"
    F[customers]
   
    F[customers] ---id30([customer_city])
    F[customers] ---id31([customer_state])
end


id21{order_id} -- 1 --- C[orders]
id14{order_id} -- 1 --- C[orders]
A[orders_items] -- N --- id14{order_id}
B[sellers] -- N --- id27{zip_code}
E[geolocation] -- 1 --- id27{zip_code}
F[customers] --1---id28{customer_id}


C[orders] --N---id28{customer_id}
F[customers] --N---id29{zip_code}
id29{zip_code}--N---E[geolocation]
id45{product_id}--N---H[products]
id45{product_id}--N---A[orders_items]
id47{product_category_name}--1---I[product_translations]
id47{product_category_name}--1---H[products]






subgraph "Geolocation"
    E[geolocation] ---id22([geolocation_city])
    E[geolocation] ---id23([geolocation_state])
    E[geolocation] ---id24([geolocation_lat])
    E[geolocation] ---id25([geolocation_lng])
    E[geolocation] ---id26([count])

    
end

```
<br>
<br>

# Dominio de la base de datos

Para una mejor visualización del diagrama entidad-relación, se decido no incluir los dominios dentro del diagrama, a continuación se presentan las tablas que contienen los dominios de cada atributo de la base de datos. Recordando que la manera gráfica de representar los dominios es la siguiente:

<br>

``` mermaid
graph LR
A[Entidad] --- id1([Atributo])
id1([Atributo]) --- id2{{Dominio}}
```

<br>

<table>
<tr><th> Customers </th><th>Geolocation</th></tr>
<tr><td>


| Atributo                 | Dominio     |
|--------------------------|-------------|
| customer_id              | VARCHAR(32) |
| customer_unique_id       | VARCHAR(32) |
| customer_zip_code_prefix | VARCHAR(5)  |
| customer_city            | VARCHAR(50) |
| customer_state           | VARCHAR(2)  |

</td><td>

| Atributo                    | Dominio          |
|-----------------------------|------------------|
| geolocation_zip_code_prefix | VARCHAR(5)       |
| geolocation_city            | VARCHAR(50)      |
| geolocation_state           | VARCHAR(2)       |
| geolocation_lat             | double[-90,90]   |
| geolocation_lng             | double[-180,180] |
| geolocation_count           | int[1,999999]    |

</td></tr> </table>

<br>

<table>
<tr><th> Order_items </th><th>order_payments</th></tr>
<tr><td>

| Atributo            | Dominio                       |
|---------------------|-------------------------------|
| order_id            | VARCHAR(32)                   |
| order_item_id       | int[1,999]                    |
| product_id          | VARCHAR(32)                   |
| seller_id           | VARCHAR(32)                   |
| shipping_limit_date | DATE[01-01-2016 : 31-12-2018] |
| price               | double(0,99999]               |
| freight_value       | double[0,99999]               |
</td><td>

| Atributo             | Dominio         |
|----------------------|-----------------|
| order_id             | VARCHAR(32)     |
| payment_sequential   | int[1,999]      |
| payment_type         | VARCHAR(32)     |
| payment_installments | int[0,999]      |
| payment_value        | double(0,99999] |
</td></tr> </table>

<br>

<table>
<tr><th>  order_review  </th><th>orders</th></tr>
<tr><td>

| Atributo                | Dominio                           |
|-------------------------|-----------------------------------|
| review_id               | VARCHAR(32)                       |
| order_id                | VARCHAR(32)                       |
| review_score            | int[1,5]                          |
| review_comment_title    | VARCHAR(50)                       |
| review_comment_message  | VARCHAR(500)                      |
| review_creation_date    | DATE[01-01-2016 : 31-12-2018]     |
| review_answer_timestamp | DATETIME[01-01-2016 : 31-12-2018] |

</td><td>


| Atributo                      | Dominio                           |
|-------------------------------|-----------------------------------|
| order_id                      | VARCHAR(32)                       |
| customer_id                   | VARCHAR(32)                       |
| order_status                  | VARCHAR(24)                       |
| order_purchase_timestamp      | DATETIME[01-01-2016 : 31-12-2018] |
| order_approved_at             | DATETIME[01-01-2016 : 31-12-2018] |
| order_delivered_carrier_date  | DATETIME[01-01-2016 : 31-12-2018] |
| order_delivered_customer_date | DATETIME[01-01-2016 : 31-12-2018] |
| order_estimated_delivery_date | DATE[01-01-2016 : 31-12-2018]     |

</td></tr> </table>

<br>


<table>
<tr><th>  products  </th><th>sellers</th></tr>
<tr><td>

| Atributo                   | Dominio      |
|----------------------------|--------------|
| product_id                 | VARCHAR(32)  |
| product_category_name      | VARCHAR(50)  |
| product_name_lenght        | int[1,999]   |
| product_description_lenght | int[1,9999]  |
| product_photos_qty         | int[1,25]    |
| product_weight_g           | int[1,99999] |
| product_length_cm          | int[1,999]   |
| product_height_cm          | int[1,999]   |
| product_width_cm           | int[1,999]   |

</td><td>

| Atributo               | Dominio     |
|------------------------|-------------|
| seller_id              | VARCHAR(32) |
| seller_zip_code_prefix | VARCHAR(5)  |
| seller_city            | VARCHAR(50) |
| seller_state           | VARCHAR(2)  |

</td></tr> </table>


<br>


| product_category_name         |             |
|-------------------------------|-------------|
| Atributo                      | Dominio     |
| product_category_name         | VARCHAR(50) |
| product_category_name_english | VARCHAR(50) |


