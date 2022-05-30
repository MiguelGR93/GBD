-- Miguel Gonzalez Ruiz -- 

Create database U6Practica1_GonzalezRuiz_Miguel;
use U6Practica1_GonzalezRuiz_Miguel;


CREATE TABLE departamento (

	id int primary key not null,
    nombre varchar(45),
    localidad varchar(45) 
    );
    
    CREATE TABLE empleado (
    
    id int primary key not null,
    nombre varchar(45),
    trabajo varchar(45),
    cod_jefe int,
    fechaContratacion Date,
    salario Double,
    comision Double,
    id_depto int 
    );
    
    alter table empleado add constraint fk_cod_jefe foreign key (cod_jefe) references empleado(id);
    
    alter table empleado add constraint fk_id_depto foreign key (id_depto) references departamento(id);
    
    
    -- pequeño truco para establecer las comprobaciones de las claves foreaneas a cero --
    
    SET FOREIGN_KEY_CHECKS=0;
    
    -- INSERTAMOS LOS DATOS TABLA DEPARTAMENTO -- 
    
    insert into departamento values (10,'CONTABILIDAD','NEW YORK');
    insert into departamento values (20,'INVESTIGACION','DALLAS');
    insert into departamento values (30,'VENTAS','CHICAGO');
    insert into departamento values (40,'OPERACIONES','BOSTON');
    
    
    -- INSERTAMOS LOS DATOS TABLA EMPLEADO -- 
    
    insert into empleado values(7369,'SMITH','ADMINISTRADOR',7902,'1980-12-17',800,NULL,20);
    insert into empleado values(1499,'ALLEN','VENDEDOR',7698,'1981-02-20',1600,300,30);
    insert into empleado values(7521,'WARD','VENDEDOR',7698,'1981-02-22',1250,500,30);
    insert into empleado values(7566,'JONES','MANAGER',7839,'1981-04-02',2975,NULL,20);
    insert into empleado values(7654,'MARTIN','VENDEDOR',7698,'1981-09-28',1250,1400,30);
    insert into empleado values(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850,NULL,30);
    insert into empleado values(7782,'CLARK','MANAGER',7839,'1981-06-09',2450,NULL,10);
    insert into empleado values(7788,'SCOTT','ANALISTA',7566,'1982-12-09',3000,NULL,20);
    insert into empleado values(7839,'KING','DIRECTOR',NULL,'1981-11-17',5000,NULL,10);
    insert into empleado values(7844,'TURNER','VENDEDOR',7698,'1981-09-08',1500,0,30);
    insert into empleado values(7876,'ADAMS','ADMINISTRADOR',7788,'1983-01-12',1100,NULL,20);
    insert into empleado values(7900,'JAMES','ADMINISTRADOR',7698,'1981-12-03',950,NULL,30);
    insert into empleado values(7902,'FORD','ANALISTA',7566,'1981-12-03',3000,NULL,20);
    insert into empleado values(7934,'MILLER','ADMINISTRADOR',7782,'1982-01-23',1300,NULL,10);
    
    
    -- Miguel Gonzalez Ruiz -- 
    /* 1. Obtener todos los datos de todos los empleados. */
    
    select * from empleado;
    
    -- Miguel Gonzalez Ruiz -- 
/* 2. Obtener todos los datos de todos los departamentos. */

select * from departamento;

-- Miguel Gonzalez Ruiz -- 
/* 3. Obtener todos los datos de los administrativos */

select * 
from empleado
where trabajo LIKE 'ADMINISTRADOR';

-- Miguel Gonzalez Ruiz -- 
/* 4. Idem, pero ordenado por el nombre.*/

select * 
from empleado
where trabajo LIKE 'ADMINISTRADOR'
order by nombre;

-- Miguel Gonzalez Ruiz -- 
/* 5. Obtén el código, nombre y salario de los empleados.*/

select id,nombre,salario
from empleado;

-- Miguel Gonzalez Ruiz -- 
/* 6. Lista los nombres de todos los departamentos.*/

select nombre 
from departamento;

-- Miguel Gonzalez Ruiz -- 
/* 7. Idem, pero ordenándolos por nombre. */

select nombre 
from departamento
order by nombre;

-- Miguel Gonzalez Ruiz -- 
/*8. Idem, pero ordenándose por la ciudad (no se debe seleccionar la ciudad en el
resultado). */

select nombre 
from departamento
order by localidad;

-- Miguel Gonzalez Ruiz -- 
/*9. Idem, pero el resultado debe mostrarse ordenado por la ciudad en orden inverso. */

select nombre 
from departamento
order by localidad DESC;

-- Miguel Gonzalez Ruiz -- 
/* 10. Obtener el nombre y empleo de todos los empleados, ordenado por salario.*/

select nombre,trabajo 
from empleado
order by salario;

-- Miguel Gonzalez Ruiz -- 
/*11. Obtener el nombre y empleo de todos los empleados, ordenado primero por su
trabajo y luego por su salario. */

select nombre,trabajo 
from empleado
order by trabajo, salario;

-- Miguel Gonzalez Ruiz -- 
/*12. Idem, pero ordenando inversamente por empleo y normalmente por salario.*/

select nombre,trabajo 
from empleado
order by trabajo DESC, salario;

-- Miguel Gonzalez Ruiz -- 
/* 13. Obtén los salarios y las comisiones de los empleados del departamento 30.*/

select salario, comision
from empleado 
where id_depto=30;

-- Miguel Gonzalez Ruiz -- 
 /*14. Idem, pero ordenado por comisión. */
 
select salario, comision
from empleado 
where id_depto=30
order by comision;
 
 -- Miguel Gonzalez Ruiz -- 
 /* 15. Obtén las comisiones de todos los empleados.*/
 
 select comision
 from empleado;
 
 -- Miguel Gonzalez Ruiz -- 
/* 16. Obtén las comisiones de los empleados de forma que no se repitan.*/

select distinct comision
from empleado;

-- Miguel Gonzalez Ruiz -- 
/*17. Obtén el nombre de empleado y su comisión SIN FILAS repetidas. */

select distinct nombre,comision  
from empleado;

-- Miguel Gonzalez Ruiz -- 
/* 18. Obtén los nombres de los empleados y sus salarios, de forma que no se repitan
filas.*/

select distinct nombre, salario
from empleado;

-- Miguel Gonzalez Ruiz -- 
/* 19. Obtén las comisiones de los empleados y sus números de departamento, de
forma que no se repitan filas.*/

select distinct comision, id_depto
from empleado;

-- Miguel Gonzalez Ruiz -- 
/*20. Obtén los nuevos salarios de los empleados del departamento 30, que resultan
de sumar a su salario una gratificación de 1000. Muestra también los nombres de los
empleados. No es un UPDATE */

select nombre,salario+1000 as 'Nuevo Salario' 
from empleado  
where id_depto=30;

-- Miguel Gonzalez Ruiz -- 
/*21. Lo mismo que la anterior, pero mostrando también su salario original, y haz que
la columna con el nuevo salario se denomine nuevoSalario. */

select nombre,salario,salario+1000 as 'Nuevo Salario' 
from empleado  
where id_depto=30;

-- Miguel Gonzalez Ruiz -- 
/* 22. Halla los empleados que tienen una comisión superior a la mitad de su salario. */

select * 
from empleado 
where comision > (salario/2);

-- Miguel Gonzalez Ruiz -- 
/*23. Halla los empleados que no tienen comisión, o que la tengan menor o igual que
el 25 % de su salario.*/

select *
from empleado 
where comision is null or comision <= (salario/4);

-- Miguel Gonzalez Ruiz -- 
/*24. Obtén una lista de nombres de empleados y sus salarios, de forma que en la
salida aparezca en todas las filas “Nombre:” y “Salario:” antes del respectivo campo. */

select concat('Nombre:  ',nombre,' ','Salario: ', salario) as 'Nombre y Salario'
from empleado;

-- Miguel Gonzalez Ruiz -- 
/*25. Hallar el código, salario y comisión de los empleados cuyo código sea mayor que
7500. */

select id,salario,comision
from empleado
where id > 7500;

-- Miguel Gonzalez Ruiz -- 
/*26. Obtén el salario, comisión y salario total (salario+comisión) de los empleados con
comisión, ordenando el resultado por número de empleado.*/

select salario,comision,(salario+comision) as 'Salario Total' 
from empleado
where comision is not null
order by id;

-- Miguel Gonzalez Ruiz -- 
/*27. Lista la misma información, pero para los empleados que no tienen comisión. */

select salario,comision,(salario+comision) as 'Salario Total' 
from empleado
where comision is null
order by id;

-- Miguel Gonzalez Ruiz -- 
/*28. Muestra el nombre de los empleados que, teniendo un salario superior a 1000,
tengan como jefe al empleado cuyo código es 7698.*/

select nombre
from empleado
where salario > 1000 and cod_jefe = 7698;

-- Miguel Gonzalez Ruiz -- 
/*29. Indica para cada empleado el porcentaje que supone su comisión sobre su
salario, ordenando el resultado por el nombre del mismo. */

select *, (comision*100/salario+comision) as 'Porcentaje'
from empleado
order by nombre;

-- Miguel Gonzalez Ruiz -- 
/*30. Hallar los empleados del departamento 10 cuyo nombre no contiene la cadena
LA.*/

select * 
from empleado
where id_depto=10 and upper(nombre) not like '%LA%';

-- Miguel Gonzalez Ruiz -- 
/*31. Obten los empleados que no son supervisados por ningún otro. */

select *
from empleado
where cod_jefe is null;

-- Miguel Gonzalez Ruiz -- 
/*32. Obtén los nombres de los departamentos que no sean VENTAS ni
INVESTIGACION. Ordena el resultado por la localidad del departamento.*/

select nombre
from departamento 
where nombre not like 'VENTAS' and nombre not like 'INVESTIGACION' 
order by localidad;

-- Miguel Gonzalez Ruiz -- 
/*33. Deseamos conocer el nombre de los empleados y el código del departamento de
los administrativos que no trabajan en el departamento 10, y cuyo salario es superior a 800,
ordenado por fecha de contratación. */

select nombre, id_depto
from empleado
where trabajo  like 'ADMINISTRADOR' and id_depto !=10 and salario > 800
order by fechaContratacion;


-- Miguel Gonzalez Ruiz -- 
/*34. Para los empleados que tengan comisión, obten sus nombres y el cociente entre
su salario y su comisión (excepto cuando la comisión sea cero), ordenando el resultado por
nombre.*/

select nombre, (salario/comision) as ' Cociente Salario y Comision' 
from empleado
where comision is not null 
and comision > 0 
order by nombre;

-- Miguel Gonzalez Ruiz -- 
/*35. Lista toda la información sobre los empleados cuyo nombre completo tenga
exactamente 5 caracteres. */

select * 
from empleado
where length(nombre) =5;

-- Miguel Gonzalez Ruiz -- 
/*36. Lo mismo, pero para los empleados cuyo nombre tenga al menos cinco letras. */

select * 
from empleado
where length(nombre) >=5;


-- Miguel Gonzalez Ruiz -- 
/*37. Halla los datos de los empleados que, o bien su nombre empieza por A y su
salario es superior a 1000, o bien reciben comisión y trabajan en el departamento 30. */

select * 
from empleado
where (upper(nombre) like 'A%' and salario > 1000 ) or (comision is not null and id_depto=30);


-- Miguel Gonzalez Ruiz -- 
/*38. Halla el nombre, el salario y el sueldo total de todos los empleados, ordenando el
resultado primero por salario y luego por el sueldo total. En el caso de que no tenga
comisión, el sueldo total debe reflejar sólo el salario */
    
 select nombre, salario,ifnull(salario+comision,salario) as 'Sueldo total' 
 from empleado
 order by salario,(salario+comision);
    
    