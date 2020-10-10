# Tarea 2: Temporización

## Autor
```
Jorge Muñoz Taylor 
A53863
jorge.munoztaylor@ucr.ac.cr
```

## Reporte
Se encuentra en el repositorio con nombre: 
```
tarea2_A53863.pdf
```

## Como ejecutar el código
Ubíquese en la carpeta raíz de la tarea: 
```
cd $(PATH)/microelectronica_tarea2
```

El makefile se disenó para ejecutar 6 escenarios diferentes:

```
a. Ejecutar Yosys para obtener el archivo contador_synt.v con el contador sintetizado.

b. Probar el contador conductual.

c. Probar el contador sintetizado sin retardos.

d. Probar el contador sintetizado con retardos.

e. Elimina los ejecutables y los logs creados.

f. Ejecutar todos los pasos anteriores en orden de forma automática.
```

La forma de ejecutar cada escenario se muestra a continuación:

```
a. $ make YOSYS    
b. $ make probar
c. $ make probar_synt
d. $ make probar_retardo
e. $ make clean
```

Cada simulación (excepto make clean) creará un archivo de LOG en la carpeta logs, ahí podrá analizar la salida producida por verilog, los resultados también se imprimirán en la terminal.

```
Note que sólo se imprimirá en el archivo log cuando ocurra un error, es decir, si la simulación termina sin encontrar errores el archivo log no tendrá nada escrito en él, salvo el encabezado. 
```

## Bibliotecas y/o programas necesarios
```
1. Icarus verilog 
2. Yosys 
3. GTKwave
4. Ubuntu (creado en Ubuntu 18.04)
5. Algún programa que permita leer PDF
```

## II-2020