-- Miguel Gonzalez Ruiz-- 

SET GLOBAL log_bin_trust_function_creators =1;

/* 1. Escribe una función que reciba un número entero de entrada y devuelva TRUE
si el número es par o FALSE en caso contrario */ 

DELIMITER $$
DROP FUNCTION IF EXISTS PAROIMPAR$$
CREATE function PAROIMPAR(numero integer) returns varchar (50)
BEGIN

DECLARE tipo varchar(50) default "";

if mod(numero,2)=0 THEN
	set tipo = 'TRUE';
else set tipo = 'FALSE';
end if;
return(tipo);

END$$
DELIMITER ;
    
select 2 as 'Comprobacion Numero', PAROIMPAR(2) as 'TRUE O FALSE' ;
select 4 as 'Comprobacion Numero', PAROIMPAR(4) as 'TRUE O FALSE' ;
select 5 as 'Comprobacion Numero', PAROIMPAR(5) as 'TRUE O FALSE' ;
select 9 as 'Comprobacion Numero', PAROIMPAR(9) as 'TRUE O FALSE' ;

/* 2. Escribe una función que devuelva el valor de la hipotenusa de un triángulo a
partir de los valores de sus lados. */ 

DELIMITER $$
DROP FUNCTION IF EXISTS hipotenusa$$
CREATE FUNCTION hipotenusa (lado1 float, lado2 float) RETURNS float 

BEGIN 

DECLARE hip FLOAT;

SET hip = SQRT(POW(lado1,2) + POW(lado2,2));

RETURN hip; 

END$$

DELIMITER ;

SELECT hipotenusa ( 3, 4 ) as ' Hipotenusa del triangulo ' ;

/* 3. Escribe una función que reciba como parámetro de entrada un valor numérico
que represente un día de la semana y que devuelva una cadena de
caracteres con el nombre del día de la semana correspondiente. Por ejemplo,
para el valor de entrada 1 debería devolver la cadena lunes. */

DELIMITER $$
DROP FUNCTION IF EXISTS DIASEMANA$$
CREATE FUNCTION DIASEMANA(dia int) returns varchar (50)

BEGIN 
	DECLARE nombre VARCHAR(50);
    if (dia >= 1 and dia <=7) then   
    CASE dia 
		when 1 then set nombre ='Lunes';
        when 2 then set nombre ='Martes';
        when 3 then set nombre ='Miercoles';
        when 4 then set nombre = 'Jueves'; 
		when 5 then set nombre = 'Viernes';
        when 6 then set nombre = 'Sabado';
        when 7 then set nombre = 'Domingo';
	else Set nombre= ' El dia no es correcto';
    END CASE;
    else Set nombre= ' El dia dado no es un valor correcto';
    END IF;
    RETURN nombre;
    
    END$$
    DELIMITER ;

select 1 as 'DIA DE LA SEMANA ', DIASEMANA(1) as "Nombre dia";
select 2 as 'DIA DE LA SEMANA ', DIASEMANA(2) as "Nombre dia";
select 3 as 'DIA DE LA SEMANA ', DIASEMANA(3) as "Nombre dia";
select 4 as 'DIA DE LA SEMANA ', DIASEMANA(4) as "Nombre dia";
select 5 as 'DIA DE LA SEMANA ', DIASEMANA(5) as "Nombre dia";
select 6 as 'DIA DE LA SEMANA ', DIASEMANA(6) as "Nombre dia";
select 7 as 'DIA DE LA SEMANA ', DIASEMANA(7) as "Nombre dia";
select 8 as 'DIA DE LA SEMANA ', DIASEMANA(8) as "Nombre dia";


/* 4. Escribe una función que reciba tres números como parámetros de entrada y
devuelva el mayor de los tres. */ 


DELIMITER $$ 
DROP FUNCTION IF EXISTS NUMEROMAYOR$$
CREATE FUNCTION NUMEROMAYOR ( numero1 int, numero2 int, numero3 int) RETURNS VARCHAR(50)

BEGIN 

DECLARE nmayor varchar(50);

if numero1 > numero2 and numero1 > numero3 THEN SET nmayor = numero1;

elseif numero2 > numero1 and numero2 > numero3 THEN SET nmayor=numero2;

else SET nmayor=numero3;

END IF;

RETURN nmayor;

END$$
DELIMITER ;

SELECT 5 AS 'Numero 1', 10 AS 'Numero 2', 20 AS 'Numero 3', NUMEROMAYOR(5,10,20) as ' El numero mayor es';
SELECT 10 AS 'Numero 1', 50 AS 'Numero 2', 4 AS 'Numero 3', NUMEROMAYOR(10,50,4) as ' El numero mayor es';
SELECT 100 AS 'Numero 1', 50 AS 'Numero 2', 4 AS 'Numero 3', NUMEROMAYOR(100,50,4) as ' El numero mayor es';


/* 5. Escribe una función que devuelva el valor del área de un círculo a partir del
valor del radio que se recibirá como parámetro de entrada. */ 

DELIMITER $$
DROP FUNCTION IF EXISTS area_circulo$$
CREATE FUNCTION area_circulo(r double) RETURNS DOUBLE

BEGIN 

DECLARE area double;
Set area= PI() * POW(r,2);

return area;

END$$
Delimiter ;

Select area_circulo (10.54) as 'Area del circulo en m2' ;


/* 6. Escribe una función que devuelva como salida el número de años que han
transcurrido entre dos fechas que se reciben como parámetros de entrada.
Por ejemplo, si pasamos como parámetros de entrada las fechas 2018-01-01
y 2008-01-01 la función tiene que devolver que han pasado 10 años. */ 

DELIMITER $$
DROP FUNCTION IF EXISTS anos_fechas$$
CREATE FUNCTION anos_fechas (fecha_uno DATE, fecha_dos DATE) RETURNS varchar(255) 

BEGIN 
DECLARE diferencia varchar(255);
SET diferencia =  concat("La diferencia en años es: ",DATEDIFF(fecha_dos,fecha_uno)/365);

return diferencia;

end$$

DELIMITER ;

SELECT anos_fechas ('2008-01-01','2018-01-01') as ' Diferencia en años entre fechas';


/* 7. Escribe una función que reciba una cadena de caracteres como parámetro, y
devuelva la cadena invertida. Por ejemplo, si introducimos la cadena:
“Holamundo”, debe devolver la cadena “odnumaloH”. Ayuda: deberás utilizar
funciones como substring(), length() y bucles. */ 

DELIMITER $$ 
DROP FUNCTION IF EXISTS cadena_invertida$$
CREATE FUNCTION cadena_invertida(cadena varchar(255)) returns varchar(255)

BEGIN 
DECLARE c_invertida varchar(255) default "";
DECLARE longitud_cadena int;

SET longitud_cadena = length(cadena);

while longitud_cadena > 0 DO 

SET c_invertida =  concat(c_invertida,substr(cadena,longitud_cadena,1));

SET longitud_cadena = longitud_cadena - 1;

end WHILE;

RETURN c_invertida;

END$$

DELIMITER ;

SELECT cadena_invertida('Hola Mundo') as 'Cadena invertida';



