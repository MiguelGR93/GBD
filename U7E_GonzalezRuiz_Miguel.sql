-- Miguel Gonzalez Ruiz-- 

SET GLOBAL log_bin_trust_function_creators =1;

/* 1. 2,5 puntos. Crea un procedimiento que reciba un parámetro de entrada y otro de
salida. El de entrada será un número entero. El de salida será un parámetro de tipo
texto. El procedimiento deberá comprobar si el número introducido está entre 0 y 10,
y guardará en el parámetro de salida, las primeras 4 potencias de ese número,
empezando esas potencias desde 0, como un texto separado por “-”. Si el número
no está entre 0 y 10, deberá guardar en el parámetro de salida el siguiente mensaje :
“Número no válido”. AYUDA: para calcular potencias se utiliza la función
POW(base,exponente)
Ejemplo de llamada :
call ejercicio1 (4, @resultado)
call ejercicio1 (-1, @resultado2)
Ejemplo de resultado al hacer “SELECT @resultado”
1 - 4 - 16 - 64
Ejemplo de resultado al hacer “SELECT @resultado2”
Número no válido*/ 

DELIMITER $$
DROP PROCEDURE IF EXISTS ejercicio1$$
CREATE PROCEDURE ejercicio1(in numero1 int, out cadena varchar(255))
begin

declare iterador int default  0;
set cadena = ' ' ;


if numero1 between 0 and 10 then

	while iterador <4 do
		if iterador <= 2 then 
			set cadena = concat(cadena, pow(numero1,iterador),' - ');
		else 
        	set cadena = concat(cadena, pow(numero1,iterador));
        end if;
	set iterador = iterador +1;
    end while;
    
else set cadena= "Numero no valido";

end if;

end $$ 

delimiter ;

call ejercicio1(4,@resultado1);
select @resultado1 as 'Mensaje';
call ejercicio1(-1,@resultado2);
select @resultado2 as 'Mensaje';



/* 2. 2,5 puntos. Crea una función llamada operadora, que reciba tres parámetros num1,
num2 y operador. Los números serán enteros. El operador podrá ser $,%, &, (. La
función devolverá como resultado la aplicación de la operación a los operandos
anteriores, según lo siguiente:
$: realizará la suma de los dos números
%: realizará la potencia (POW) de num1 elevado a num2
&: realizará la división entre num1/num2
(: realizará la operación módulo (MOD) entre num1 y num2
Si recibe cualquier otro operador, deberá devolver el valor -1
El tipo de dato que devuelve la función debe ser acorde a los valores que
puede devolver. */ 


DELIMITER $$
DROP FUNCTION IF EXISTS operadora$$
CREATE FUNCTION operadora(num1 int, num2 int, operador varchar(1)) returns float
begin 

declare v_resultado float default 0.0;

case operador

when '$' then set v_resultado = num1 + num2;
when '%' then set v_resultado = pow(num1,num2);
when '&' then set v_resultado = num1/num2;
when '(' then set v_resultado = mod(num1,num2);

else set v_resultado = -1;

end case;

return v_resultado;

end $$ 

delimiter ;

select operadora(2,3,'$') as 'Suma', operadora(2,3,'%') as 'potencia', operadora(2,3,'&') as 'Division', operadora(2,3,'(') as' Modulo', operadora(2,3,'+') as 'Error';

/* 3. 2,5 puntos. Crea una función que tenga 2 parámetros, nif y curso_académico. La
función deberá calcular la nota media de ese alumno para ese curso académico, y la
media general de dicho curso académico. Si la nota media del alumno, es mayor que
la general, la función deberá devolver 1, si es igual o menor, devolverá 0. */ 


DELIMITER $$
DROP FUNCTION IF EXISTS Notamedia$$
CREATE FUNCTION Notamedia(f_nif varchar(9), f_cursoAcademico varchar(45)) returns int
begin

declare regreso int;
declare v_notaMedia_alumno float default 0;
declare v_notaMedia_general float default 0;

select avg(m.nota) into v_notaMedia_alumno from matricula m where m.nif like f_nif and m.cursoAcademico like f_cursoAcademico;

select avg(m2.nota) into v_notaMedia_general from matricula m2 where m2.cursoAcademico like f_cursoAcademico;

if v_notaMedia_alumno > v_notaMedia_general then
	set regreso = 1;
else set regreso =0;

end if;

return regreso;
end $$

delimiter ;

select Notamedia('33333333C','2020-21') as 'Mensaje';
select Notamedia('66666666F','2021-22') as 'Mensaje';


/* 4. 2,5 puntos. Un hacker ha conseguido entrar en la base de datos de notas del
instituto, y ha decidido crear un trigger para favorecer a aquellos alumnos que se
llaman Dario. El trigger debe cumplir las siguientes condiciones:
a. Se ejecuta sobre la tabla alumnos.
b. Se ejecuta antes de una operación de actualización.
c. Cuando se actualice el nombre de un alumno, si el nombre contiene el texto
“Dario” , todas las notas de ese alumno en la tabla matrícula pasarán a ser
un 10.
Deberás incluir una operación de actualización que dispare el trigger */


DELIMITER $$
DROP TRIGGER IF EXISTS eljacker$$
Create trigger eljacker
BEFORE UPDATE on alumnos
for each row
begin 

if(new.nombre like '%Dario%') then
update matricula set nota=10 where nif=old.nif;
end if;

end $$
delimiter ;

update alumnos set nombre = 'dario' where nif like '11111111A';

