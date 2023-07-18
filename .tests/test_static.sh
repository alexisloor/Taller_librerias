#!/bin/bash

source $(dirname "$0")/globals

LIB="libsha256.a"
EXEC="hash256"
EXPECTED_SIZE=800000

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
make static&>/dev/null

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
    echo -e "$PASS Librería estática creada"
else
	clean_fail "No existe la librería estática"
fi

SIZE=$(stat -c %s $EXEC)
if [ "$SIZE" -gt "$EXPECTED_SIZE" ] ; then
	echo -e "$PASS Linking estático detectado"
else
	clean_fail "No hay linking estático"
fi

clean
echo
