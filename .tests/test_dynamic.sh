#!/bin/bash

source $(dirname "$0")/globals

LIB="libsha256.so"
EXEC="hash256"
EXPECTED_SIZE=20000

clean(){
	make clean &>/dev/null
	rm -f $EXEC $LIB
}

clean_fail(){
	clean
	echo -e "$FAIL " $1
	exit 1
}

clean
make dynamic&>/dev/null

if [ $? -eq 0 ] ; then
	echo -e "$PASS Compilación exitosa"
else
	clean_fail "Error de compilación"
fi

RANDOM_TXT=$(tr -dc "a-z" </dev/urandom | head -c 10)
HASH=$(echo -n $RANDOM_TXT | sha256sum | tr -d " -")

OUTPUT=$(./$EXEC $RANDOM_TXT)

if [ $? -eq 0 ] ; then
	echo -e "$PASS Ejecución exitosa"
else
	clean_fail "Error en tiempo de ejecución"
fi

echo "Texto de prueba usado: $RANDOM_TXT"
echo "Salida del programa: $OUTPUT"
echo "Salida esperada: $HASH"

if [ "$OUTPUT" == "$HASH" ] ; then
	echo -e "$PASS Hashing exitoso"
else
	clean_fail "Error de hashing"
fi

if [ -f "$LIB" ]; then
    echo -e "$PASS Librería dinámica creada"
else
	clean_fail "No existe la librería dinámica"
fi

SIZE=$(stat -c %s $EXEC)
if [ "$SIZE" -lt "$EXPECTED_SIZE" ] ; then
	echo -e "$PASS Linking dinámico detectado"
else
	clean_fail "No hay linking dinámico"
fi

clean
echo
