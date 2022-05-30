-- Miguel Gonzalez Ruiz --


/* 1. Escribe un procedimiento que no tenga ningún parámetro de entrada ni de
salida y que muestre el texto ¡Hola mundo!. */

DELIMITER $$
DROP PROCEDURE IF EXISTS HolaMundo$$
CREATE PROCEDURE HolaMundo()

BEGIN 
SELECT "HOLA MUNDO" as 'Mensaje';

END $$

DELIMITER ;
CALL HolaMundo();


/* 2. Escribe un procedimiento que reciba un número real de entrada y muestre un
mensaje indicando si el número es positivo, negativo o cero. */ 

DELIMITER $$ 
DROP PROCEDURE IF EXISTS TipoNumero$$
CREATE PROCEDURE TipoNumero(IN numero INT)
BEGIN

IF numero > 0 THEN SELECT " El numero es positivo"  as 'TipoDeNumero' ;
elseif numero < 0 THEN SELECT " El numero es negativo" as 'TipoDeNumero' ;
Else  SELECT " El numero es cero" as 'TipoDeNumero' ;
END IF;


END $$
DELIMITER ;

call TipoNumero(-4);
call TipoNumero(0);
call TipoNumero(16);





/* 3. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga
un parámetro de entrada, con el valor un número real, y un parámetro de
salida, con una cadena de caracteres indicando si el número es positivo,
negativo o cero. */

DELIMITER $$ 
DROP PROCEDURE IF EXISTS TipoNumeroDos$$
CREATE PROCEDURE TipoNumeroDos(IN numero INT, OUT resultado varchar(50))
BEGIN

IF numero > 0 THEN SET resultado=" El numero es positivo"  ;
elseif numero < 0 THEN SET  resultado=" El numero es negativo";
Else  SET resultado= " El numero es cero";
END IF;


END $$
DELIMITER ;

call TipoNumeroDos(10,@CadenaDeTipoNumero);
Select @CadenaDeTipoNumero;
call TipoNumeroDos(-4,@CadenaDeTipoNumero);
Select @CadenaDeTipoNumero;
call TipoNumeroDos(0,@CadenaDeTipoNumero);
Select @CadenaDeTipoNumero;


/* 4. Escribe un procedimiento que reciba un número real de entrada, que
representa el valor de la nota de un alumno, y muestre un mensaje indicando
qué nota ha obtenido teniendo en cuenta las siguientes condiciones:
● [0,5) = Insuficiente
● [5,6) = Aprobado
● [6, 7) = Bien
● [7, 9) = Notable
● [9, 10] = Sobresaliente
● En cualquier otro caso la nota no será válida. */


DELIMITER $$ 
DROP PROCEDURE IF EXISTS NotaDeAlumno$$
CREATE PROCEDURE NotaDeAlumno(IN numero INT)
BEGIN

IF numero >=0 and numero <5 THEN SELECT " Insuficiente" as 'Nota' ;
elseif numero >=0 and numero <6 THEN SELECT " Aprobado" as 'Nota';
elseif numero >=6 and numero <7 THEN SELECT " Bien" as 'Nota';
elseif numero >=7 and numero <9 THEN SELECT " Notable" as 'Nota';
elseif numero >=9 and numero <=10 THEN SELECT " Sobresaliente" as 'Nota';
Else  SELECT " Nota no valida";
END IF;


END $$
DELIMITER ;

call NotaDeAlumno(-5);
call NotaDeAlumno(4);
call NotaDeAlumno(5);
call NotaDeAlumno(6); 
call NotaDeAlumno(8); 
call NotaDeAlumno(10);





/* 5. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga
un parámetro de entrada, con el valor de la nota en formato numérico y un
parámetro de salida, con una cadena de texto indicando la nota
correspondiente. */

DELIMITER $$ 
DROP PROCEDURE IF EXISTS NotaDeAlumnoDos$$
CREATE PROCEDURE NotaDeAlumnoDos(IN numero INT,OUT resultado varchar(50))
BEGIN

IF numero >=0 and numero <5 THEN SET resultado= " Insuficiente";
elseif numero >=0 and numero <6 THEN SET resultado= " Aprobado";
elseif numero >=6 and numero <7 THEN SET resultado= " Bien";
elseif numero >=7 and numero <9 THEN SET resultado= " Notable";
elseif numero >=9 and numero <=10 THEN SET resultado= " Sobresaliente";
Else  SET resultado= " Nota no valida";
END IF;


END $$
DELIMITER ;

call NotaDeAlumnoDos(-10,@NotaDelAlumno);
Select @NotaDelAlumno;
call NotaDeAlumnoDos(4,@NotaDelAlumno);
Select @NotaDelAlumno;
call NotaDeAlumnoDos(5,@NotaDelAlumno);
Select @NotaDelAlumno;
call NotaDeAlumnoDos(6,@NotaDelAlumno);
Select @NotaDelAlumno;
call NotaDeAlumnoDos(8,@NotaDelAlumno);
Select @NotaDelAlumno;
call NotaDeAlumnoDos(10,@NotaDelAlumno);
Select @NotaDelAlumno;


/* 6. Resuelva el procedimiento diseñado en el ejercicio anterior haciendo uso de
la estructura de control CASE. */ 

DELIMITER $$ 
DROP PROCEDURE IF EXISTS NotaDeAlumnoTres$$
CREATE PROCEDURE NotaDeAlumnoTres(IN numero INT,OUT resultado varchar(50))
BEGIN

	Case 
		When numero>=0 and numero <5 THEN SET resultado= " Insuficiente";
		When numero >=0 and numero <6 THEN SET resultado= " Aprobado";
		When numero >=6 and numero <7 THEN SET resultado= " Bien";
		When numero >=7 and numero <9 THEN SET resultado= " Notable";
		When numero >=9 and numero <=10 THEN SET resultado= " Sobresaliente";
		ELSE 
			BEGIN
				SET resultado= " Nota no valida";
			END;
		END CASE;

END $$
DELIMITER ;

call NotaDeAlumnoTres(-10,@NotaDelAlumnoTres);
Select @NotaDelAlumnoTres;
call NotaDeAlumnoTres(2,@NotaDelAlumnoTres);
Select @NotaDelAlumnoTres;
call NotaDeAlumnoTres(5,@NotaDelAlumnoTres);
Select @NotaDelAlumnoTres;
call NotaDeAlumnoTres(6,@NotaDelAlumnoTres);
Select @NotaDelAlumnoTres;
call NotaDeAlumnoTres(7,@NotaDelAlumnoTres);
Select @NotaDelAlumnoTres;
call NotaDeAlumnoTres(9,@NotaDelAlumnoTres);
Select @NotaDelAlumnoTres;




/* 7. Escribe un procedimiento que reciba como parámetro de entrada un valor
numérico que represente un día de la semana y que devuelva una cadena de
caracteres con el nombre del día de la semana correspondiente. Por ejemplo,
para el valor de entrada 1 debería devolver la cadena lunes. */

DELIMITER $$ 
DROP PROCEDURE IF EXISTS DiaDeLaSemana$$
CREATE PROCEDURE DiaDeLaSemana(IN numero INT)
BEGIN

	Case numero 
		When 1 THEN SELECT " Lunes" as 'Dia';
		When 2 THEN SELECT " Martes" as 'Dia';
        When 3 THEN SELECT " Miercoles" as 'Dia';
        When 4 THEN SELECT " Jueves" as 'Dia';
        When 5 THEN SELECT " Viernes" as 'Dia';
        When 6 THEN SELECT " Sabado" as 'Dia';
        When 7 THEN SELECT " Domingo" as 'Dia';
		ELSE 
			BEGIN
				SELECT " Dia no válido";
			END;
		END CASE;

END $$
DELIMITER ;

Call DiaDeLaSemana(1);
Call DiaDeLaSemana(2);
Call DiaDeLaSemana(3);
Call DiaDeLaSemana(4);
Call DiaDeLaSemana(5);
Call DiaDeLaSemana(6);
Call DiaDeLaSemana(7);
Call DiaDeLaSemana(0);


/* 8. Crea un procedimiento que reciba tres números num1, num2 y num3 y que
muestre por pantalla cuál es el mayor. Por ejemplo, si el procedimiento es
llamado con los parámetros, 5,7,2 deberá indicar: “El mayor es 7”. */ 

DELIMITER $$ 
DROP PROCEDURE IF EXISTS CualEsMayor$$
CREATE PROCEDURE CualEsMayor(IN numero INT, In numero2 INT, IN numero3 INT)
BEGIN

	Case  
		When numero>numero2 and numero>numero3  THEN SELECT concat(" El mayor es: ",numero) as 'Numero Mayor';
		When numero2>numero and numero2>numero3  THEN SELECT concat(" El mayor es: ",numero2) as 'Numero Mayor';
        When numero3>numero and numero3>numero  THEN SELECT concat(" El mayor es: ",numero3) as 'Numero Mayor';
		ELSE 
			BEGIN
				SELECT " Ha habido un error";
			END;
		END CASE;

END $$
DELIMITER ;

Call CualEsMayor(3,2,5);
Call CualEsMayor(10,50,20);
Call CualEsMayor(100,50,20);



/* 9. Crea un procedimiento que devuelva en una variable de salida la cantidad de
números que hay divisores de 3 hasta el número 100. Utilizar bucle WHILE*/ 


Delimiter $$
DROP PROCEDURE IF EXISTS DivisoresDeTres$$
CREATE PROCEDURE DivisoresDeTres(OUT divisor INT)
BEGIN


DECLARE i INT DEFAULT 0;
set divisor=0;

WHILE i <=100 DO
 if (mod(i,3)=0)
	THEN SET divisor = divisor +1;
 end if;   
 
 set i=i+1;

End while;

END $$
Delimiter ;

Call DivisoresDeTres(@NumDivisores);
select @NumDivisores;

/* 10.Crea el mismo procedimiento anterior pero con un bucle REPEAT */ 

Delimiter $$
DROP PROCEDURE IF EXISTS DivisoresDeTresRepeat$$
CREATE PROCEDURE DivisoresDeTresRepeat(OUT divisorTres INT)
BEGIN


DECLARE i INT DEFAULT 0;
set divisorTres=0;

REPEAT 
 if (mod(i,3)=0)
	THEN SET divisorTres = divisorTres +1;
 end if;   
  
 
 set i=i+1;

UNTIL i =100 End REPEAT;

END $$
Delimiter ;

Call DivisoresDeTresRepeat(@NumDivisoresRepeat);
select @NumDivisoresRepeat;

 