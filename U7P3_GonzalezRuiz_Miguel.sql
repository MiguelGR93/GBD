-- Miguel Gonzalez Ruiz -- 

SET GLOBAL log_bin_trust_function_creators =1;


/* 1. Crea un procedimiento que reciba como parámetros los datos de un alumno
(nif, nombre, localidad y fecha de nacimiento), el curso académico y el
nombre de un módulo, y matricule a dicho alumno en dicho módulo para ese
curso. Se deberán comprobar las siguientes condiciones:


- Si el módulo no existe, debe mostrar un mensaje indicando tal hecho.
- Si el alumno no existe en la base de datos, hay que añadirlo a la
misma.
- Si el alumno ya está matriculado en esa asignatura para ese curso,
debe mostrar un mensaje indicando esa situación. */

/* --------------------------------------------------------------------------------------*/
DELIMITER $$
DROP PROCEDURE IF EXISTS matriculacionv2$$
CREATE PROCEDURE matriculacionv2(in f_nif varchar(10),in f_nombre varchar(45), in f_localidad varchar(45),in f_fechanacimiento date ,in f_cursoAcademico varchar(45),in f_nombreModulo varchar(45) )
BEGIN 

declare v_idasignatura_Modulo int default -1;
declare v_nif_alumno varchar(10) default 'null' ;
declare v_nif_alumno_matriculado varchar(10) default 'null';

select asig.idasignatura into v_idasignatura_Modulo from asignaturas asig where asig.nombre like f_nombreModulo;
select al.nif into v_nif_alumno from alumnos al where al.nif like f_nif;
select m.nif into v_nif_alumno_matriculado from matricula m where f_nif=m.nif and v_idasignatura_Modulo = idasignatura and F_cursoAcademico like cursoAcademico;

if v_idasignatura_Modulo = -1 then
	select concat(" El modulo ",f_nombreModulo,' No existe') as 'Mensaje error modulo';
    else
		if ( v_nif_alumno = 'null' ) then
				insert into alumnos values (f_nif,f_nombre,f_localidad,f_fechanacimiento);
		end if;
        if ( v_nif_alumno_matriculado = 'null') then
			insert into matricula (nif,idasignatura,cursoAcademico,nota) values (f_nif,v_idasignatura_Modulo,f_cursoAcademico,null);
		else 
			select concat(" El alumno/a ",f_nombre,' ya está matriculado en el modulo ', f_nombreModulo, ' en el curso ', f_cursoAcademico) as 'Mensaje ya matriculado' ;
		end if;
        
end if;

END $$
delimiter ;

call matriculacionv2('11111111A','JUAN GOMEZ','VÉLEZ-MÁLAGA','2000-04-12','2021-22','HH');
call matriculacionv2('11111111G','JUANILLO GOMEZ','VÉLEZ-MÁLAGA','2000-04-12','2021-22','IAW'); 
call matriculacionv2('11111111G','JUANILLO GOMEZ','VÉLEZ-MÁLAGA','2000-04-12','2021-22','IAW');



/* 2. Crea un procedimiento al que le pasamos como parámetro el DNI del
alumno y un curso académico y nos almacene en una variable de salida de
tipo texto, el número de aprobados con respecto del total de asignaturas
matriculadas.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS NumeroAprobados $$
CREATE PROCEDURE NumeroAprobados(IN dni varchar(9), IN curso varchar(45), OUT numAprobados varchar(255))
BEGIN 

declare n_aprobados int default 0;
declare ntotal int default 0;

select COUNT(*) 
into ntotal 
from matricula
where nif 
like dni and cursoAcademico like curso;

SELECT COUNT(*)
INTO n_aprobados
FROM matricula
WHERE matricula.nif like dni and matricula.cursoAcademico like curso and  matricula.nota >= 5;

set numAprobados = concat('El alumno con DNI ',dni,' ha aprobado ',n_aprobados,' de ',ntotal,' asignaturas ', 'en el curso ' , curso);

END $$

DELIMITER ;

CALL NumeroAprobados('11111111A','2021-22',@totalAprobados);
SELECT @totalAprobados as ' Numero Total de Aprobados por Curso';
CALL NumeroAprobados('22222222B','2021-22',@totalAprobados);
SELECT @totalAprobados as ' Numero Total de Aprobados por Curso';

/* 3. Crea un procedimiento que muestre por pantalla el número de alumnos que
pasarán por cada una de las aulas del instituto un curso académico
determinado. Nota: las aulas van del número 1 al número 30. */ 

DELIMITER $$
DROP PROCEDURE IF EXISTS NumAlumnosPorAula$$
CREATE PROCEDURE NumAlumnosPorAula(in p_cursoAcademico varchar(45))
BEGIN 

declare iterador int default 1;
declare AlumnosAula int ;


while iterador <= 30 do

	Select count(alum.nif) into AlumnosAula
	from (alumnos alum inner join matricula m on alum.nif = m.nif )
	inner join asignaturas asig on m.idasignatura = asig.idasignatura
	where asig.aula = iterador and m.cursoAcademico = p_cursoAcademico;


	select concat('En el curso: ',p_cursoAcademico,' tantos alumnos: ', AlumnosAula, ' han pasado por el aula: ', iterador) as 'Alumnos por aula';

	set iterador = iterador + 1 ;

end while;

END $$
delimiter ;

call NumAlumnosPorAula('2020-21');


/* 4. Crea una función que reciba como parámetro la localidad y el curso
académico, y devuelva la media obtenida por los alumnos de dicha localidad
para ese curso académico.  return Double */

DELIMITER $$
DROP FUNCTION IF EXISTS MediaAlumnosLocalidad $$
CREATE FUNCTION MediaAlumnosLocalidad (f_localidad varchar(45),f_cursoAcademico varchar(45)) returns double
BEGIN

declare media double;

select avg(m.nota) into media from matricula m
inner join alumnos alum on m.nif=alum.nif where alum.localidad like f_localidad and m.cursoAcademico like f_cursoAcademico;

return media;

end $$
delimiter ;

select MediaAlumnosLocalidad('VÉLEZ MÁLAGA','2021-22') as 'Media de los alumnos por localidad';


/* 5. Crea una función que reciba como parámetro el nombre de un módulo, y un
curso académico, y devuelva el porcentaje de alumnos aprobados.  return double */ 

delimiter $$
DROP FUNCTION if exists PorcentajeAprobado$$
CREATE FUNCTION PorcentajeAprobado(f_nombreModulo varchar(45), f_CursoAcademico varchar(45)) returns double
BEGIN

declare porcentaje_aprob double;
declare total int default 0;
declare numaprobado int default 0;

select count(distinct(m.nif)) into total from matricula m 
inner join asignaturas asig on m.idasignatura = asig.idasignatura
where asig.nombre like f_nombreModulo and m.cursoAcademico like f_CursoAcademico;

select count(distinct(m.nif)) into numaprobado from matricula m 
inner join asignaturas asig on m.idasignatura = asig.idasignatura
where asig.nombre like f_nombreModulo and m.cursoAcademico like f_CursoAcademico and m.nota>=5 ;

set porcentaje_aprob = ((numaprobado *100) / total);

return porcentaje_aprob;

end $$
delimiter ;

select PorcentajeAprobado('GBD','2020-21') as 'Porcentaje de aprobados por curso y modulo';


/* 6. Crea una función que reciba como parámetro el número de un aula y un
curso académico, y devuelva el número de alumnos que pasarán por esa
aula dicho curso. return int  */ 

DELIMITER $$
DROP FUNCTION IF EXISTS NumeroAlumnosPorAula$$
CREATE FUNCTION NumeroAlumnosPorAula(f_NumeroAula varchar(45), f_CursoAcademico varchar(45))  returns int 
begin 

declare num_alumnos_aula int default 0;

select count(distinct(m.nif)) into num_alumnos_aula 
from matricula m inner join asignaturas asig 
on m.idasignatura = asig.idasignatura where m.cursoAcademico like f_CursoAcademico and asig.aula like f_NumeroAula; 

return num_alumnos_aula;


end $$ 
delimiter ; 


select NumeroAlumnosPorAula('15','2020-21') as 'Numero de alumnos que pasan por el aula';

