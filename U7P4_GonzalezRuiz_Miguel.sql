-- Miguel Gonzalez Ruiz -- 

    
 /* Ejercicio 1. Crear un trigger que se llame guardar_alumnos_eliminados y que
cumpla las siguiente condiciones:
● Se ejecuta sobre la tabla alumnos.
● Se ejecuta después de una operación de borrado.
● Cada vez que se elimine un alumno de la tabla se deberá insertar un nuevo
registro en una tabla llamada log_alumnos_eliminados que tenga 3 campos
(nif_eliminado,nombre_eliminado,fecha_hora_eliminacion) */ 


CREATE TABLE log_alumnos_eliminados(
	nif_eliminado varchar(9) primary key,
    nombre_eliminado varchar(45),
    fecha_hora_eliminado datetime
    );

 
DELIMITER $$ 
DROP TRIGGER IF EXISTS eliminaralumno $$
CREATE TRIGGER eliminaralumno
AFTER DELETE on alumnos
for each row
begin

 Insert into log_alumnos_eliminados (nif_eliminado,nombre_eliminado,fecha_hora_eliminado) values (old.nif,old.nombre,now());
 
 end $$
 
 delimiter ; 
 
 Delete from alumnos where nif like '88888888H';


/* Ejercicio 2. Crear un trigger que se llame comprobar_cambio_aula y que cumpla
las siguientes condiciones:
● Se ejecuta sobre la tabla asignaturas
● Se ejecuta Antes de una operación de actualización.
● Comprueba que cuando se actualice el valor de un aula, esos valores deben
estar entre el 1 y el 30. Si no es así, actualizar al valor -1. */



DELIMITER $$
DROP TRIGGER IF EXISTS comprobar_cambio_alumno $$
CREATE TRIGGER comprobar_cambio_alumno
BEFORE UPDATE on asignaturas
for each row
begin

if new.aula not between 1 and 30 then 
	set new.aula = -1;
end if;

end $$

delimiter ;

UPDATE asignaturas set aula=18 where idasignatura = 2;
UPDATE asignaturas set aula=40 where idasignatura = 1;

/* Ejercicio 3. Crear un nuevo atributo en la tabla matricula, llamado nota_texto, cuyo
valor por defecto sea NULL. Crear un trigger que se llame insertar_nota_texto que
cumpla las siguientes condiciones:
● Se ejecuta sobre la tabla matricula
● Se ejecuta Antes de añadir un nuevo registro a la tabla
● Comprueba que el valor de la nota esté entre 0 y 10, y actualiza el valor del
campo “nota_texto” a la nota correspondiente según lo siguiente:
○ [0,5): insuficiente
○ [5,7): aprobado
○ [7,9): notable
○ [9,10): sobresaliente
○ 10: matrícula de honor
○ Otro valor: “Nota errónea” */ 

alter table matricula add nota_texto varchar(255) default 'null';

DELIMITER $$
DROP TRIGGER IF EXISTS insertar_nota_texto $$
CREATE TRIGGER insertar_nota_texto
Before insert on matricula
for each row
begin 

if new.nota between 0 and 10 then 
	if new.nota < 5 then set new.nota_texto ='Insuficiente';
		elseif new.nota <7 then set new.nota_texto='Aprobado';
        elseif new.nota <9 then set new.nota_texto='Notable';
        elseif new.nota <10 then set new.nota_texto='Sobresaliente';
        elseif new.nota = 10 then set new.nota_texto='Matricula de honor';
    end if;
    else set new.nota_texto='Nota erronea';
end if;
end $$ 

delimiter ;

Insert into matricula (nif,idasignatura,cursoAcademico,nota) values ('77777777G',2,'2020-21',8);
Insert into matricula (nif,idasignatura,cursoAcademico,nota) values ('77777777G',3,'2020-21',10);
Insert into matricula (nif,idasignatura,cursoAcademico,nota) values ('77777777G',4,'2020-21',11);

/* 4 Crear un trigger llamado guardar_cambios_nota que almacene en una
tabla llamada “cambios_nota”, cuándo se ha producido un cambio en una nota ya
almacenada. Es decir, cada vez que se actualice una nota de la tabla matrícula,
deberá almacenar el nif del alumno, id del módulo, curso académico, nota anterior,
nota nueva y cuándo se ha actualizado. */ 

CREATE TABLE cambios_nota(
	nif_nota_cambiada varchar(9) primary key,
    id_asignatura_cambiada int,
    curso_academico_cambiada varchar(45),
    nota_anterior int,
    nota_nueva int,
    fecha_hora_actualizado datetime
    );


DELIMITER $$
DROP TRIGGER IF EXISTS guardar_cambios_nota $$ 
CREATE TRIGGER guardar_cambios_nota
before update on matricula
for each row
Begin


 Insert into cambios_nota  values (old.nif,old.idasignatura,old.cursoAcademico,old.nota,new.nota,now());


end $$
delimiter ; 


update matricula set nota = 10 where nif like '77777777G' and idAsignatura = 2 and cursoAcademico like '2020-21';





