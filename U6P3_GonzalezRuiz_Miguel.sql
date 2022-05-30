-- Miguel González Ruiz -- 

DROP DATABASE IF EXISTS ventas; 
CREATE DATABASE ventas CHARACTER SET utf8mb4; 
USE ventas;  


CREATE TABLE cliente (   
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,   
nombre VARCHAR(100) NOT NULL,   
apellido1 VARCHAR(100) NOT NULL,   
apellido2 VARCHAR(100),   
ciudad VARCHAR(100),   
categoría INT UNSIGNED );  

CREATE TABLE comercial (   
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,   
nombre VARCHAR(100) NOT NULL,   
apellido1 VARCHAR(100) NOT NULL,   
apellido2 VARCHAR(100),   
comisión FLOAT );  

CREATE TABLE pedido (   
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,   
total DOUBLE NOT NULL,   
fecha DATE,   
id_cliente INT UNSIGNED NOT NULL,   
id_comercial INT UNSIGNED NOT NULL,   
FOREIGN KEY (id_cliente) REFERENCES cliente(id),   
FOREIGN KEY (id_comercial) REFERENCES comercial(id) );  

INSERT INTO cliente VALUES(1, 'Aarón', 'Rivero', 'Gómez', 'Almería', 100);
INSERT INTO cliente VALUES(2, 'Adela', 'Salas', 'Díaz', 'Granada', 200);
INSERT INTO cliente VALUES(3, 'Adolfo', 'Rubio', 'Flores', 'Sevilla', NULL);
INSERT INTO cliente VALUES(4, 'Adrián', 'Suárez', NULL, 'Jaén', 300); 
INSERT INTO cliente VALUES(5, 'Marcos', 'Loyola', 'Méndez', 'Almería', 200);
INSERT INTO cliente VALUES(6, 'María', 'Santana', 'Moreno', 'Cádiz', 100);
INSERT INTO cliente VALUES(7, 'Pilar', 'Ruiz', NULL, 'Sevilla', 300);
INSERT INTO cliente VALUES(8, 'Pepe', 'Ruiz', 'Santana', 'Huelva', 200);
INSERT INTO cliente VALUES(9, 'Guillermo', 'López', 'Gómez', 'Granada', 225);
INSERT INTO cliente VALUES(10, 'Daniel', 'Santana', 'Loyola', 'Sevilla', 125);
INSERT INTO comercial VALUES(1, 'Daniel', 'Sáez', 'Vega', 0.15);
INSERT INTO comercial VALUES(2, 'Juan', 'Gómez', 'López', 0.13);
INSERT INTO comercial VALUES(3, 'Diego','Flores', 'Salas', 0.11);
INSERT INTO comercial VALUES(4, 'Marta','Herrera', 'Gil', 0.14);
INSERT INTO comercial VALUES(5, 'Antonio','Carretero', 'Ortega', 0.12);
INSERT INTO comercial VALUES(6, 'Manuel','Domínguez', 'Hernández', 0.13);
INSERT INTO comercial VALUES(7, 'Antonio','Vega', 'Hernández', 0.11);
INSERT INTO comercial VALUES(8, 'Alfredo','Ruiz', 'Flores', 0.05);
INSERT INTO pedido VALUES(1, 150.5, '2017-10-05', 5, 2);
INSERT INTO pedido VALUES(2, 270.65, '2016-09-10', 1, 5);
INSERT INTO pedido VALUES(3, 65.26, '2017-10-05', 2, 1);
INSERT INTO pedido VALUES(4, 110.5, '2016-08-17', 8, 3);
INSERT INTO pedido VALUES(5, 948.5, '2017-09-10', 5, 2);
INSERT INTO pedido VALUES(6, 2400.6, '2016-07-27', 7, 1);
INSERT INTO pedido VALUES(7, 5760, '2015-09-10', 2, 1);
INSERT INTO pedido VALUES(8, 1983.43, '2017-10-10', 4, 6);
INSERT INTO pedido VALUES(9, 2480.4, '2016-10-10', 8, 3);
INSERT INTO pedido VALUES(10, 250.45, '2015-06-27', 8, 2);
INSERT INTO pedido VALUES(11, 75.29, '2016-08-17', 3, 7);
INSERT INTO pedido VALUES(12, 3045.6, '2017-04-25', 2, 1);
INSERT INTO pedido VALUES(13, 545.75, '2019-01-25', 6, 1);
INSERT INTO pedido VALUES(14, 145.82, '2017-02-02', 6, 1);
INSERT INTO pedido VALUES(15, 370.85, '2019-03-11', 1, 5);
INSERT INTO pedido VALUES(16, 2389.23, '2019-03-11', 1, 5);


/* Consultas sobre una tabla

1. Devuelve un listado con todos los pedidos que se han realizado. Los pedidos deben
estar ordenados mostrando en primer lugar los pedidos más recientes.*/

select *
from pedido
order by fecha DESC;

/* 2. Devuelve un listado con los identificadores de los clientes que han realizado algún
pedido. Tenga en cuenta que no debes mostrar identificadores que estén repetidos.*/

select distinct id_cliente
from pedido;


/*3. Devuelve un listado de todos los pedidos que se realizaron durante el año 2017, cuya
cantidad sea superior a 500€.*/

select *
from pedido 
where year(fecha)=2017  and total > 500;


/*4. Devuelve un listado con el nombre y los apellidos de los comerciales que tienen una
comisión entre 0.05 y 0.11.*/

select nombre, apellido1,apellido2  
from comercial
where comisión between 0.05 and 0.11;


/*5. Devuelve el valor de la comisión de mayor y menor valor que existe en la
tabla comercial.*/

select min(comisión) as 'Comision Minima', max(comisión) as 'Comision Maxima' 
from comercial ;



/*6. Devuelve el identificador, nombre y primer apellido de aquellos clientes cuyo segundo
apellido no es NULL. El listado deberá estar ordenado alfabéticamente por apellidos y nombre */

select id,nombre,apellido1
from cliente
where apellido2 is not null
order by apellido1, nombre;


/*7. Devuelve un listado de los nombres de los clientes que empiezan por A y terminan
por o y también los nombres que empiezan por a. El listado deberá estar ordenado
alfabéticamente. */

select nombre
from cliente
where upper(nombre) like 'A%O' or upper(nombre) like 'A%'
order by nombre;



/* 8. Devuelve un listado con los nombres de los comerciales que terminan por el o. Tenga
en cuenta que se deberán eliminar los nombres repetidos.*/


select distinct nombre 
from comercial
where upper(nombre) like '%O' ;


/*Consultas con varias tablas*/   

/*9. Devuelve un listado con el identificador y nombre de todos los clientes que han
realizado algún pedido. El listado debe estar ordenado alfabéticamente y se deben
eliminar los elementos repetidos. */

select distinct c.id, c.nombre 
from cliente c, pedido p 
where c.id=p.id_cliente
order by c.nombre;



/*10. Devuelve un listado de todos el id y los nombres de clientes, que realizaron un pedido
durante el año 2017, cuya cantidad está entre 300 € y 1000 €. */

select  distinct c.id, c.nombre 
from cliente c, pedido p 
where c.id=p.id and year(p.fecha)=2017 and total between 300 and 1000
order by c.nombre; 


/* Consultas con subconsultas*/


/* 11. Devuelve el nombre y los apellidos de todos los comerciales que ha participado en
algún pedido realizado por María Santana Moreno.*/

select distinct co.nombre, co.apellido1, co.apellido2
from comercial co, cliente c, pedido p 
where co.id=p.id_comercial and p.id_cliente=c.id and p.id_cliente=
		(select id
		from cliente c2
		where c2.nombre like 'María' and c2.apellido1 like 'Santana' and c2.apellido2 like 'Moreno');



/*12. Devuelve el nombre de todos los clientes que han realizado algún pedido con algún
comercial apellidado Vega. */

select distinct c.nombre
from comercial co, cliente c, pedido p,
	(select id
        from comercial co2
        where co2.apellido1 like 'Vega' or co2.apellido2 like 'Vega') as Vega
where co.id=p.id_comercial and p.id_cliente=c.id and Vega.id=p.id_comercial ;



/*13. Devuelve un listado que solamente muestre los clientes que no han realizado ningún
pedido.*/

select c.*
from cliente c,
(select c2.id
					from pedido p2
                    right join cliente c2
                    on c2.id=p2.id_cliente
					where p2.id_cliente is null) as nulo
where c.id=nulo.id;




/*14. Devuelve un listado que solamente muestre los comerciales que no han realizado
ningún pedido. */

select c.*
from comercial c,
(select c2.id
					from pedido p2
                    right join comercial c2
                    on c2.id=p2.id_comercial
					where p2.id_comercial is null) as nulo
where c.id=nulo.id;



/*Consultas con agrupamientos o con funciones de agrupación.*/


/*15. Calcula la cantidad total y la cantidad media de todos los pedidos que aparecen en la
tabla pedido. */

select sum(total) as 'Cantidad Total', avg(total) as ' Cantidad Media'
from pedido;


/* 16. Calcula el número total de clientes que aparecen en la tabla cliente.*/

select distinct count(id) as 'Numero total de clientes' 
from cliente;

/* 17. Calcula cuál es la mayor y la menor cantidad que aparece en la tabla pedido.*/

select min(total) as 'Cantidad menor', max(total) as ' Cantidad mayor' 
from pedido;

/*18. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número
total de pedidos que ha realizado cada uno de clientes.*/

select c.id,c.nombre, c.apellido1, c.apellido2, count(p.id_cliente) as ' Total de pedidos que ha realizado cada cliente'
from cliente c
left join pedido p
on c.id=p.id_cliente
group by c.id;

/*19. Haz el ejercicio 18 teniendo en cuenta que pueden existir clientes que no han realizado
ningún pedido. Estos clientes no deben aparecer en el listado.*/

select c.id,c.nombre, c.apellido1, c.apellido2, count(p.id_cliente) as ' Total de pedidos que ha realizado cada cliente'
from cliente c, pedido p
where c.id=p.id_cliente
group by p.id_cliente;

/* 20. Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado cada uno de clientes durante el año 2017 */

select c.id,c.nombre, c.apellido1, c.apellido2, count(p.id_cliente) as ' Total de pedidos que ha realizado cada cliente'
from cliente c, pedido p
where c.id=p.id_cliente and year(p.fecha)=2017
group by p.id_cliente;

/*Subconsultas*/


/*21. Devuelve un listado con todos los pedidos que ha realizado Adela Salas Díaz. (Usando
subconsulta) */

select distinct p.*
from comercial co, cliente c, pedido p 
where co.id=p.id_comercial and p.id_cliente=c.id and p.id_cliente=
		(select id
		from cliente c2
		where c2.nombre like 'Adela' and c2.apellido1 like 'Salas' and c2.apellido2 like 'Díaz');


/*22. Devuelve el número de pedidos en los que ha participado el comercial Daniel Sáez
Vega. (Usando subconsulta)*/

select distinct count(p.id)
from comercial co, pedido p 
where co.id=p.id_comercial  and p.id_comercial=
		(select id
		from comercial c2
		where c2.nombre like 'Daniel' and c2.apellido1 like 'Sáez' and c2.apellido2 like 'Vega');


/*23. Devuelve los datos del cliente que realizó el pedido más caro en el año 2019. (Usando
subconsulta)*/

select distinct c.*
from cliente c
where c.id= 
		(select p2.id_cliente
		from  pedido p2
        where  p2.total =  
				(select max(p3.total)
				from pedido p3
				where year(p3.fecha)=2019)) ;


/*24. Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe
Ruiz Santana.*/

select distinct p.fecha, min(p.total)
from  pedido p
where   p.id_cliente= 
		(select c.id
		from  cliente c
        where  c.nombre like 'Pepe' and c.apellido1 like 'Ruiz' and c.apellido2 like 'Santana'); 
				

/*25. Devuelve el pedido más caro que existe en la tabla pedido sin hacer uso de MAX.*/

select p.*
from pedido p
where p.total >= ALL
	(select p2.total
	 from pedido p2);


/*26. Devuelve un listado de los clientes que no han realizado ningún pedido.*/

select c.*
from cliente c,
(select c2.id
		from cliente c2 
		left join pedido p2
		on c2.id=p2.id_cliente
        where p2.id_cliente is null ) as ninguno
where  c.id=ninguno.id;


/*27. Devuelve un listado de los comerciales que no han realizado ningún pedido. Hazlo de 2
formas diferentes.*/

select co.*
from comercial co,
(select co2.id
		from comercial co2 
		left join pedido p2
		on co2.id=p2.id_comercial
        where p2.id_comercial is null ) as ninguncomercial
where  co.id=ninguncomercial.id;


select co.*
from comercial co,
(select co2.id
		from pedido p2 
		right join comercial co2
		on co2.id=p2.id_comercial
        where p2.id_comercial is null ) as ninguncomercial
where  co.id=ninguncomercial.id;




 