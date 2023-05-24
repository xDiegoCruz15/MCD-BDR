# Tarea 3





1. Customer(<u> customer_id </u>,customer_unique_id,customer_zip_code_prefix,customer_city,customer_state)

1. Orders(<u>order_id</u>,customer_id,order_status,order_purchase_timestamp,order_approved_at,order_delivered_carrier_date,order_delivered_customer_date,order_estimated_delivery_date)

1. Order_items(<u>order_id</u>,<u>order_item_id</u>,product_id,seller_id,shipping_limit_date,price,freight_value)

1. Products(<u>product_id</u>,product_category_name,product_name_lenght,product_description_lenght,product_photos_qty,product_weight_g,product_length_cm,product_height_cm,product_width_cm)

1. Sellers(<u>seller_id</u>,seller_zip_code_prefix,seller_city,seller_state)

2. Payments(payment_sequential,payment_type,payment_installments,payment_value)

3. Order_reviews(order_id,review_id,review_score,review_comment_title,review_comment_message,review_creation_date,review_answer_timestamp)

4. Geolocation(<u>geolocation_zip_code</u>,<u>geolocation_lat</u>,geolocation_lng,geolocation_city,geolocation_state)

5. Product_category_translation(<u>product_category_name</u>,product_category_name_english)


![Diagrama](https://github.com/xDiegoCruz15/MCD-BDR/blob/master/Tarea3/Imagenes/Diagrama%20ER.png?raw=true)