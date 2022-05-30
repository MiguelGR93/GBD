-- Miguel Gonzalez Ruiz--

CREATE DATABASE datosEmpresa;
USE datosEmpresa;

-- ---------------- --
-- TABLA TRABAJADOR --
-- ---------------- --
CREATE TABLE TRABAJADOR (
ID_T INT PRIMARY KEY,
NOMBRE CHAR(20) NOT NULL,
TARIFA REAL NOT NULL,
OFICIO CHAR(15) NOT NULL
);

ALTER TABLE TRABAJADOR ADD ID_SUPV INT NULL REFERENCES TRABAJADOR;

-- -------------- --
-- TABLA EDIFICIO --
-- -------------- --
CREATE TABLE EDIFICIO (
ID_E INT NOT NULL PRIMARY KEY,
DIR CHAR(15) NOT NULL,
TIPO CHAR (10) NOT NULL,
NIVEL_CALIDAD INT NOT NULL,
CATEGORIA INT NOT NULL
);

-- ---------------- --
-- TABLA ASIGNACION --
-- ---------------- --
CREATE TABLE ASIGNACION (
ID_T INT NOT NULL REFERENCES TRABAJADOR,
ID_E INT NOT NULL REFERENCES EDIFICIO,
FECHA_INICIO DATETIME NOT NULL,
NUM_DIAS INT,
PRIMARY KEY (ID_T, ID_E, FECHA_INICIO)
);


-- ---------------- --
-- TABLA TRABAJADOR --
-- ---------------- --
INSERT INTO TRABAJADOR  VALUES (1235,'M. FARADAY',12.5,'ELECTRICISTA',1311);
INSERT INTO TRABAJADOR  VALUES (1311,'C. COULOMB',15.5,'ELECTRICISTA',NULL);
INSERT INTO TRABAJADOR VALUES (1412,'C. NEMO',13.75,'FONTANERO',1520);
INSERT INTO TRABAJADOR VALUES (1520,'H. RICKOVER',11.75,'FONTANERO',NULL);
INSERT INTO TRABAJADOR VALUES (2920,'R. GARRET',10,'ALBAÑIL',NULL);
INSERT INTO TRABAJADOR VALUES (3001,'J. BARRISTER',8.2,'CARPINTERO',3231);
INSERT INTO TRABAJADOR VALUES (3231,'P. MASON',17.4,'CARPINTERO',NULL);



-- -------------- --
-- TABLA EDIFICIO --
-- -------------- --
INSERT INTO EDIFICIO VALUES (111,"1213 ASPEN","OFICINA",4,1);
INSERT INTO EDIFICIO VALUES (210,"1011 BIRCH","OFICINA",3,1);
INSERT INTO EDIFICIO VALUES (312,"123 ELM","OFICINA",2,2);
INSERT INTO EDIFICIO VALUES (435,"456 MAPLE","COMERCIO",1,1);
INSERT INTO EDIFICIO VALUES (460,"1415 BEACH","ALMACEN",3,3);
INSERT INTO EDIFICIO VALUES (515,"789 OAK","RESIDENCIA",3,2);
-- ---------------- --
-- TABLA ASIGNACION --
-- ---------------- --
INSERT INTO ASIGNACION VALUES (1235,312,'2001-10-10',5);
INSERT INTO ASIGNACION VALUES (1235,515,'2001-10-17',22);
INSERT INTO ASIGNACION VALUES (1311,435,'2001-10-08',12);
INSERT INTO ASIGNACION VALUES (1311,460,'2001-10-23',24);
INSERT INTO ASIGNACION VALUES (1412,111,'2001-12-01',4);
INSERT INTO ASIGNACION VALUES (1412,210,'2001-11-15',12);
INSERT INTO ASIGNACION VALUES (1412,312,'2001-10-01',10);
INSERT INTO ASIGNACION VALUES (1412,435,'2001-10-15',15);
INSERT INTO ASIGNACION VALUES (1412,460,'2001-10-08',18);
INSERT INTO ASIGNACION VALUES (1412,515,'2001-11-05',8);
INSERT INTO ASIGNACION VALUES (1520,312,'2001-10-30',17);
INSERT INTO ASIGNACION VALUES (1520,515,'2001-10-09',14);
INSERT INTO ASIGNACION VALUES (2920,210,'2001-11-10',15);
INSERT INTO ASIGNACION VALUES (2920,435,'2001-10-28',10);
INSERT INTO ASIGNACION VALUES (2920,460,'2001-10-05',18);
INSERT INTO ASIGNACION VALUES (3001,111,'2001-10-08',14);
INSERT INTO ASIGNACION VALUES (3001,210,'2001-10-27',14);
INSERT INTO ASIGNACION VALUES (3231,111,'2001-10-10',8);
INSERT INTO ASIGNACION VALUES (3231,312,'2001-10-24',20);


-- Miguel Gonzalez Ruiz -- 
/*1. Nombre de los trabajadores cuya tarifa este entre 10 y 12 euros.*/

select nombre 
from trabajador
where tarifa between 10 and 12;


-- Miguel Gonzalez Ruiz -- 
/* 2. ¿Cuáles son los oficios de los trabajadores asignados al edificio 435?*/

select t.oficio
from trabajador t , asignacion a
where t.id_t=a.id_t and a.id_e=435;


-- Miguel Gonzalez Ruiz -- 
/*3. Indicar el nombre del trabajador y el de su supervisor.*/

select t2.nombre as 'Supervisor',t.nombre
from trabajador t, trabajador t2
where t.ID_SUPV is not null and t.ID_SUPV=t2.id_t;


-- Miguel Gonzalez Ruiz -- 
/*4. Nombre de los trabajadores asignados a oficinas */

select distinct t.nombre
from trabajador t, edificio e, asignacion a
where t.id_t=a.id_t and a.id_e= e.id_e and e.tipo like 'OFICINA' ;


-- Miguel Gonzalez Ruiz -- 
/* 5. ¿Qué trabajadores reciben una tarifa por hora mayor que la de su supervisor? */

select t.*
from trabajador t, trabajador t2
where t.id_supv=t2.id_t and t.tarifa > t2.tarifa;


-- Miguel Gonzalez Ruiz -- 
/* 6. ¿Cuál es el número total de días que se han dedicado a fontanería en el edificio 312?*/

select sum(a.num_dias) as 'Numero total de dias'
from asignacion a, trabajador t, edificio e
where e.id_e=312 and e.id_e=a.id_e and t.id_t=a.id_t and t.oficio like 'FONTANERO';


-- Miguel Gonzalez Ruiz -- 
/* 7. ¿Cuántos tipos de oficios diferentes hay?*/

select count( distinct t.oficio) as ' Numero de tipo de oficio'
from trabajador t;


-- Miguel Gonzalez Ruiz -- 
/*8. Para cada tipo de edificio, ¿Cuál es el nivel de calidad medio de los edificios con
categoría 1? Considérense sólo aquellos tipos de edificios que tienen un nivel de calidad
no mayor que 3.*/

select e.tipo, avg(nivel_calidad) as 'Calidad Media' 
from edificio e
where e.nivel_calidad <= 3 and e.categoria =1
group by tipo;

-- Miguel Gonzalez Ruiz -- 
/*9. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio?*/

select *
from trabajador 
where tarifa < (select avg(tarifa) from trabajador); 

-- Miguel Gonzalez Ruiz -- 
/*10. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio de los
trabajadores que tienen su mismo oficio?*/

select t.*
from trabajador t,trabajador t2
where t.tarifa < (select avg(t2.tarifa)
				where t.oficio=t2.oficio); 


-- Miguel Gonzalez Ruiz -- 
/*11. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio de los
trabajadores que dependen del mismo supervisor que él?*/

select t.*
from trabajador t,trabajador t2
where t.tarifa < (select avg(t2.tarifa) where t.id_supv=t2.id_supv); 

-- Miguel Gonzalez Ruiz -- 
/*12. Seleccione el nombre de los electricistas asignados al edificio 435 y la fecha en la que
empezaron a trabajar en él. */

select t.nombre,a.fecha_inicio
from trabajador t, asignacion a
where t.oficio like 'ELECTRICISTA' and a.id_e=435 and t.id_t=a.id_t;


-- Miguel Gonzalez Ruiz -- 
/*13. ¿Qué supervisores tienen trabajadores que tienen una tarifa por hora por encima de
los 12 euros? */

select t.*
from trabajador t, trabajador t2
where t2.id_supv=t.id_t and (select avg(t2.tarifa) > 12);
