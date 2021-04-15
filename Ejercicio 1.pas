{$MODE OBJFPC} 
program untitled;

uses crt,sysutils;
Type
Reporte = Record
	id: integer;
	titulo: string;
	categoria: string;
	contenido: string;
	Fecha: string;
	Status: boolean;
end;


procedure registrarReporte(reporteRegistrar: Reporte);
var 
	status, idstring: string;
	id: integer;
	fichero: text;
begin
	try begin
		write('Introduzca el id numerico: ');
		readln(reporteRegistrar.id);
		write('Introduzca el titulo: ');
		readln(reporteRegistrar.titulo);
		write('Introduzca la categoria: ');
		readln(reporteRegistrar.categoria);
		try
			MkDir(LowerCase(reporteRegistrar.categoria));
		except
			on E: Exception do if(E.ClassName = 'EInOutError') and (E.Message <> 'Access denied') then begin
				writeln('No es posible crear una nueva carpeta con dicho nombre de categoria, intentelo de nuevo...');
				exit
			end;
		end;
		Str(reporteRegistrar.id, idstring);
		if FileExists(Concat(reporteRegistrar.categoria,'\',idstring, '.txt')) then begin
			writeln('En dicha categoria ya existe un fichero con el id ingresado...');
			exit;
		end;
		write('Introduzca el contenido: ');
		readln(reporteRegistrar.contenido);
		write('Introduzca la fecha: ');
		readln(reporteRegistrar.Fecha);
		repeat
			write('Introduzca el estado (activo o inactivo): ');
			readln(status);
		until(LowerCase(status) = 'activo') or (LowerCase(status) = 'inactivo');
		if(status = 'activo') then begin
			reporteRegistrar.Status := true;
		end
		else begin
			reporteRegistrar.Status := false;
		end;
		
		assign(fichero, Concat(reporteRegistrar.categoria,'\',idstring, '.txt'));
		rewrite(fichero);
		writeLn(fichero, Concat('--- ', reporteRegistrar.titulo,' ---'));
		writeLn(fichero);
		writeLn(fichero, reporteRegistrar.contenido);
		writeLn(fichero);
		writeLn(fichero, Concat('Fecha del reporte: ', reporteRegistrar.Fecha));
		if(status = 'activo') then begin
			writeLn(fichero, 'Estado: Activo');
		end
		else begin
			writeLn(fichero, 'Estado: Inactivo');
		end;
		close( fichero ); 
	end
	except
		writeln('Se ha abortado la creación del registro debido a que la informacion insertada no es admitida...');
		exit;
	end;
	writeln('El registro ha sido creado con exito!!!');
end;

var 
	rep: Reporte;
	opcion: char;
BEGIN
	repeat
		writeln('CREANDO NUEVO REPORTE');
		writeln();
		registrarReporte(rep);
		writeln();
		write('Si desea crear un nuevo reporte, introduzca 1: ');
		readln(opcion);
		writeln();
	until(opcion <> '1');
END.

