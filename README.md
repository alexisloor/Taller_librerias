# Práctica uso de librerías
Práctica sobre uso de librerías de terceros en C para la materia Programación de Sistemas de la ESPOL.

## Instrucciones
En esta práctica se debe implementar un programa que calcule el hash [SHA-256](https://en.wikipedia.org/wiki/SHA-2) de una cadena de caracteres proporcionada por el usuario. SHA-256 produce un hash de 32 bytes a partir de un texto (o datos) de cualquier longitud.

Para implementar el algoritmo SHA-256 es necesario usar código de terceros (el algoritmo es relativamente complejo). El repositorio del código a usar está en:

* https://github.com/B-Con/crypto-algorithms

El programa debe llamarse *hash256* y tener la siguiente funcionalidad:
```
$ ./hash256 -h
Calcula el hash sha256 de una cadena de caracteres.
uso: ./hash256 <cadena_caracteres>
     ./hash256 -h
Opciones:
 -h	Ayuda, muestra este mensaje
```

El programa recibe una cadena de caracteres como argumento y debe mostrar en consola el hash sha256 en formato hexadecimal de la cadena de caracteres.

Ejemplo de ejecución:
```
$ ./hash256 hola
b221d9dbb083a7f33428d7c2a3c3198ae925614d70210e28716ccaa7cd4ddb79
```

Para comprobar el funcionamiento correcto del programa usar: https://passwordsgenerator.net/sha256-hash-generator/

o también:

```
$ echo -n hola | sha256sum
b221d9dbb083a7f33428d7c2a3c3198ae925614d70210e28716ccaa7cd4ddb79  -
```

### Compilación
Es necesario compilar *sha256.c* como librería estática o dinámica antes del proceso de linking. Es decir, *main.c* no debe ser compilado junto con sha256.c sino con la librería *libsha256.a* o *libsha256.so* dependiendo si se desea linking dinámico o estático.

Por defecto, al compilar con make, el linking debe ser estático. Para especificar explícitamente linking estático:
```
$ make static
```
Esta compilación debe producir el ejectutable *hash256* con linking estático a la librería *libsha256.a*.

Para compilar usando linking dinámico:
```
$ make dynamic
```
Esta compilación debe producir el ejectutable *hash256* con linking dinámico a la librería *libsha256.so*.

### Pruebas
El taller es autocalificado en Github Classroom, para revisar si pasa el test de compilcación estática:
```
$ make -f Testfile static
```
y dinámica:
```
$ make -f Testfile dynamic
```

## Entregable
Más de **dos** commits implementando la funcionalidad especificada.
