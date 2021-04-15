program untitled;

uses crt;

var
	i, numero, fibonacci1, fibonacci2: integer;
	fichero: text;
BEGIN
	assign(fichero, 'fibonacci.txt');
	rewrite(fichero);
	repeat
		write('Introduzca un numero para calcular la susecion de Fibonacci (mayor a 1): ');
		readln(numero);
	until(numero > 1);
	writeln();
	fibonacci1 := 1;
	fibonacci2 := 2;
	writeln(fibonacci1);
	writeln(fichero, fibonacci1);
	for i := 2 to numero do begin
		writeln(fibonacci2);
		writeln(fichero, fibonacci2);
		fibonacci2 := fibonacci1 + fibonacci2;
		fibonacci1 := fibonacci2 - fibonacci1;
	end;
	writeln();
	close( fichero ); 
	writeln('La susecion ha sido guardada en el archivo fibonacci.txt');
END.
