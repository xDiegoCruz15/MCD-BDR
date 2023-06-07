# Tarea 5
<br>

## Agregar datos ficticios o de otras fuentes de manera automática 

Se decido utilizar los datos ya exigentes dentro de la base de datos de e-commer, para ello se utilizo los datos originales en formato csv y se realizo la carga de los mismos en una base de datos de SQL, para ello se utilizaron las funciones de incorporadas dentro del software de DBeaver, para la carga de los datos.

Dentro de la carpeta correspondiente a la tarea se encuentra el archivo de nombre [**Tarea5.sql**](https://github.com/xDiegoCruz15/MCD-BDR/blob/master/Tarea5/Tarea5.sql) el cual contiene el script de creación de la base de datos y la carga de los datos. 

## Reporte de Dificultades, hallazgos y recomendaciones.


1. Se tuvo dificultades para la carga de los datos, ya que se debía de realizar la carga de los datos utilizando la terminal, por lo que se decido utilizar el software de DBeaver para la carga de los datos, ya que este permite la carga de los datos de manera masiva.

2. Al momento de crear la estructura de la base de datos con las llaves primarias y foráneas correspondientes, y tratar de importar datos, se presento un error, el cual indicaba que no se podia realizar la carga de los datos, ya que se violaba las restricciones de llave foránea. Al estar trabajando con una base de datos con multiples relaciones, se decido deshabilitar las restricciones de llave foránea, para poder realizar la carga de los datos, y posteriormente habilitar las restricciones de llave foránea.

3. Programas como DBeaver permiten una importación sencilla de datos desde archivos CSV, sin embargo, una alternativa para poder convertir un archivo CSV a un archivo SQL, es utilizar el software de notepad++ con la extension de "CSV Lint", con la cual de manera sencilla se puede convertir un CSV a un archivo SQL autocontenido, el cual puede ser ejecutado en cualquier gestor de base de datos.

4. Personalmente la sintaxis de código SQL es algo que se me dificulta un poco, por lo que scripts sencillos prefiero utilizar VScode con la extension de SQL, debió que tiene una mejor sugerencia de funciones lo cual facilita la escritura de código SQL. asi como un mejor señalamiento de errores, cabe mencionar que VScode al no ser un un programa especializado en SQL, carece de algunas funcionalidades de programas como DBeaver o MySQL Workbench. Por lo que es util apoyarse de estos programas para la gestión de bases de datos.

## Auto Evaluación.

Considerado mi trabajo realizado en las tareas previas asi en la presente, a sido correcto y que se cumple con los objetivos asignados a cada tarea, sin embargo considero que se puede mejorar, principalmente respecto a los conocimientos técnicos de SQL, ya que creo que no tengo un dominio completo de este lenguaje de programación, por lo que he recurrido a diferentes softwares o funciones para poder realizar las tareas evitando el uso de código puro en terminal, sin embargo se que con practica y tiempo se puede mejorar en este aspecto.

Por lo anterior considero que mi trabajo es de un 8.5/10.0