-- Miguel Gonzalez Ruiz--

use examenbbdd;

/* 1. ¿Cuántos alumnos celebran su cumpleaños en Marzo?  */ 

select count(*) as 'Alumnos que cumplen en Marzo'
from alumnos 
where month(fechanacimiento)=03;


/* 2.Para cada alumno que tenga una nota igual o mayor que 5, mostrar una columna
con nif, curso académico, y una columna llamada "Observaciones" con el texto:
" Nombre tiene aprobado la asignatura ASIGNATURA ", donde NOMBRE es el
nombre del alumno y ASIGNATURA el nombre de la asignatura. */


select a.nif,m.cursoAcademico,Concat(a.nombre,' tiene aprobado la asignatura ', asig.nombre,' con un ', m.nota) as 'Observaciones'
from alumnos a, matricula m, asignaturas asig 
where a.nif=m.nif and asig.idasignatura=m.idasignatura and m.nota>=5;


/* 3.Calcula la edad media (en años) de los alumnos que viven en Vélez Málaga.*/

select round(avg(abs(datediff(curdate(),a.fechanacimiento)))/365,2) as 'Edad media (en años)'
from alumnos a
where upper(a.localidad) like 'VÉLEZ MÁLAGA';


/* 4. Realiza una consulta que devuelva todas las asignaturas junto con el número de
matriculaciones totales, ordenadas de mayor a menor por ese número de
matriculaciones.*/

select asig.*,count(m.nif) as 'NumMatriculaciones'
from asignaturas asig left join matricula m
on asig.idasignatura=m.idasignatura
group by asig.idasignatura
order by NumMatriculaciones desc;



/* 5. ¿Quién es el alumno más joven de los que cursan GBD en el curso 2020-21?  */

select a.*
from alumnos a
where a.fechanacimiento IN (select max(a2.fechanacimiento)
from alumnos a2, matricula m2, asignaturas asig2
where a2.nif=m2.nif and m2.idasignatura=asig2.idasignatura 
and upper(asig2.nombre) like 'GBD' and m2.cursoAcademico like '2020-21' );


/* 6. Realiza una consulta que devuelva el nif, nombre y media de todos los alumnos en el
curso 2021-22 cuya media sea superior o igual a 5 */

select a.nif,a.nombre,avg(m.nota)
from alumnos a , matricula m
where m.cursoAcademico like '2021-22' and a.nif=m.nif 
group by a.nif
having avg(m.nota)>=5 ;
                    
                    
 /* 7. Realiza una consulta que devuelva el nif, nombre, localidad y fecha de nacimiento de
aquellos alumnos que sean más jóvenes que el más joven de los alumnos de Vélez
Málaga */ 


select a.nif,a.nombre,a.localidad,a.fechanacimiento
from alumnos a
where a.fechanacimiento >ALL (select a2.fechanacimiento 
							from alumnos a2
							where upper(a2.localidad) like 'VÉLEZ MÁLAGA');



/* 8. Realiza una consulta que devuelva cuantos días se llevan el alumno más joven y el
más viejo.*/ 

select datediff(max(fechanacimiento),min(fechanacimiento)) as 'Dias de diferencia'
from alumnos;                  



