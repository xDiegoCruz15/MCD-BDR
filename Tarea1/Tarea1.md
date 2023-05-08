# Tarea 1


## Selección y descripción base de datos  

Se seleccionó la base de datos "Brazilian E-Commerce Public Dataset" proporcionada por Olist, la cual contiene información de mas 100 mil pedidos realizados en múltiples mercados en Brasil desde 2016 hasta 2018. La base de datos se divide en varios conjuntos de datos para facilitar su comprensión y organización. Cada conjunto de datos representa una entidad diferente, como clientes, productos, pedidos, pagos o reseñas. Las relaciones entre las entidades se pueden describir mediante un esquema de datos que muestra las claves primarias y foráneas que conectan las tablas. El siguiente diagrama ilustra el esquema de datos:

![Esquema base de datos](https://github.com/xDiegoCruz15/MCD-BDR/blob/master/Tarea1/Imagenes/ERD.png?raw=true)



## Investigación SGBD

### Tipos de SGBD
Los sistemas de gestión de bases de datos (SGBD) son software que permiten crear, almacenar, modificar y consultar datos de forma eficiente y segura. Existen diferentes tipos de SGBD según el modelo de datos que utilizan para representar la información. A continuación se presenta una tabla que describe algunos de los tipos más comunes de SGBD, con ejemplos y características principales. [<sub>1</sub>](https://es.wikipedia.org/wiki/Sistema_de_gesti%C3%B3n_de_bases_de_datos)
<br>
<br>

| Tipo de SGBD        | Características                                                                                     |
|---------------------|-----------------------------------------------------------------------------------------------------|
| Relacional          | Utilizan el modelo relacional basado en tablas y el lenguaje SQL para definir y manipular los datos |
| Jerárquico          | Utilizan el modelo jerárquico basado en árboles y registros anidados                                |
| Orientado a objetos | Utilizan el modelo orientado a objetos basado en clases y objetos con atributos y métodos           |
| Documental          | Utilizan el modelo documental basado en documentos JSON o XML con estructuras flexibles             |
| NoSQL               | Utilizan modelos no relacionales basados en columnas, claves-valor, grafos, etc                     |

<br>

### SGBD Relacionales

Durante el presente curso se abordaran los SGBD Relacionales,los cuales son los más utilizados en la actualidad, debido a su simplicidad, eficiencia y estandarización. Los sistemas relacionales utilizan el modelo relacional, que consiste en organizar los datos en tablas formadas por filas y columnas donde "cada fila en una tabla es un registro con una ID única, llamada clave(key). Las columnas de la tabla contienen los atributos de los datos y cada registro suele tener un valor para cada atributo, lo que simplifica la creación de relaciones entre los puntos de datos." [<sub>2</sub>](https://www.oracle.com/mx/database/what-is-a-relational-database/)


Ah continuación se enlistan los principales SGBD relacionales:
<br>

| Sistema    | Descripción                                                                                                                                                                   | Pros                                                                                                                                                                                                                                                 | Contras                                                                                                                                                                                                                                        |
|------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| MySQL  [<sub>3</sub>](https://codigosql.top/ventajas-y-desventajas-de-mysql/),[<sub>8</sub>](https://medium.com/devopslatam/vale-la-pena-aprender-mysql-en-el-2022-a99cf931cf9b) | Un SGBD relacional de código abierto y multiplataforma que se usa ampliamente para aplicaciones web y comerciales                                                             | Es gratuito, fácil de usar, compatible con muchos lenguajes de programación y sistemas operativos, tiene una gran comunidad de usuarios y soporta gran cantidad de datos                                                                             | No tiene algunas características avanzadas como triggers o vistas materializadas, puede tener problemas de seguridad o rendimiento con consultas complejas o transacciones concurrentes, no cumple totalmente con el estándar SQL              |
| Oracle   [<sub>4</sub>](https://es.wikipedia.org/wiki/Oracle_Database)  | Un SGBD relacional comercial y multiplataforma que ofrece alta disponibilidad, seguridad y rendimiento para aplicaciones empresariales                                        | Tiene muchas características avanzadas como particionamiento, compresión, cifrado, replicación, recuperación ante desastres, etc., cumple con el estándar ACID, tiene un soporte técnico profesional y una base de datos autónoma34                  | Es costoso, complejo de administrar y configurar, requiere hardware y software específicos, puede tener problemas de compatibilidad con otros sistemas o lenguajes                                                                             |
| SQL Server[<sub>4</sub>](https://es.wikipedia.org/wiki/Microsoft_SQL_Server) | Un SGBD relacional comercial y multiplataforma que se integra con el entorno de desarrollo de Microsoft y ofrece soluciones para análisis de datos e inteligencia empresarial | Tiene una interfaz gráfica intuitiva y fácil de usar, se integra con otras herramientas de Microsoft como Visual Studio o Excel, tiene un buen rendimiento y escalabilidad, soporta procedimientos almacenados y funciones definidas por el usuario5 | Es costoso, requiere licencias por usuario o por núcleo, puede tener problemas de seguridad o estabilidad con algunas versiones o actualizaciones, no es muy compatible con otros sistemas operativos                                          |
| PostgreSQL[<sub>5</sub>](https://www.todopostgresql.com/ventajas-y-desventajas-de-postgresql/),[<sub>8</sub>](https://medium.com/devopslatam/vale-la-pena-aprender-mysql-en-el-2022-a99cf931cf9b)| Un SGBD relacional de código abierto y multiplataforma que soporta características avanzadas como tipos de datos personalizados, herencia de tablas y funciones de ventana    | Es gratuito, cumple con el estándar SQL,estabilidad y confiabilidad tiene más de 20 años de desarrollo activo y en constante mejora, soporta muchos tipos de datos y consultas complejas, tiene una arquitectura extensible y modular, tiene una gran comunidad de usuarios y desarrolladores                                                    | No tiene un soporte técnico profesional oficial, puede tener problemas de rendimiento o consumo de recursos con grandes volúmenes de datos o transacciones concurrentes, requiere conocimientos técnicos para su administración y optimización |
| SQLite   [<sub>6</sub>](https://sqlite.org/index.html)  | Un SGBD relacional de código abierto y multiplataforma que se almacena en un único archivo y se usa comúnmente para aplicaciones móviles                                      | Es gratuito, ligero, portable, fácil de usar e instalar, no requiere un servidor ni configuración previa, cumple con el estándar ACID                                                                                                                | No soporta algunas características del SQL como claves foráneas o triggers, no tiene un buen rendimiento con grandes volúmenes de datos o múltiples usuarios concurrentes, no tiene un mecanismo de autenticación o cifrado                    |
| Maria DB [<sub>7</sub>](https://mariadb.org/es/#historia),[<sub>8</sub>](https://medium.com/devopslatam/vale-la-pena-aprender-mysql-en-el-2022-a99cf931cf9b)  | Un SGBD relacional de código abierto y multiplataforma que se deriva de MySQL y ofrece compatibilidad y funcionalidades adicionales                                           | Es gratuito, compatible con MySQL, tiene una gran comunidad de usuarios y desarrolladores, soporta características avanzadas como columnas dinámicas, motores de almacenamiento alternativos o replicación galera                                |Puede tener problemas de rendimiento o estabilidad con algunas versiones o actualizaciones, no cumple totalmente con el estándar SQL                                                          |




### Elección de SGBD

Se seleccionó **MariaDB** como el sistema de gestión de bases de datos a utilizar  durante el curso. Debido a ser una version mejorada de MySQL(Sistema con el que he trabajado anteriormente) y cuenta con una alta compatibilidad con MySQL ya que la mayoría de las aplicaciones populares que utilizan MySQL funcionan sin problemas con MariaDB, ademas de incorporar mejoras en el rendimiento, la seguridad y la funcionalidad. 

#### Descripción de MariaDB

MariaDB  es un sistema de gestión de bases de datos relacionales de código abierto, compatible con MySQL, incorporando multiples mejoras tanto en el apartado de rendimiento como de funcionalidad. Fue creado por el fundador de MySQL, Monty Widenius, en 2009, y se publica bajo la licencia GPLv2(licencia de software libre). MariaDB tiene una amplia comunidad de desarrolladores y usuarios, y ofrece ventajas como la escalabilidad, la alta disponibilidad, el soporte para múltiples motores de almacenamiento y la integración con otros sistemas de datos. Por lo que MariaDB es una excelente opción para gestionar datos relacionales de forma eficiente y 
