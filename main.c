#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <string.h>
#include "sha256.h"

void print_help(char *command)
{
	printf("Calcula el hash sha256 de una cadena de caracteres.\n");
	printf("uso: %s <cadena_caracteres>\n", command);
	printf("     %s -h\n", command);
	printf("Opciones:\n");
	printf(" -h\tAyuda, muestra este mensaje\n");
}

/**
 * Función print_hex convierte los datos binarios en "data" a una representación hexadecimal en texto.
 *
 * @param data datos binarios.
 *
 * @param size cantidad de bytes en "data".
 */
void print_hex(const char* data, size_t size)
{
    int i;
    for(i = 0; i < size; ++i)
        printf("%02x",(unsigned char) data[i]);
}

int main(int argc, char **argv)
{
	char *input_string = NULL;
	char *output_string = NULL;

	
	int opt;
	while ((opt = getopt (argc, argv, "h")) != -1){
		switch(opt)
		{
			case 'h':
				print_help(argv[0]);
				return 0;
			case '?':
			default:
				fprintf(stderr, "uso: %s <cadena_caracteres>\n", argv[0]);
				fprintf(stderr, "     %s -h\n", argv[0]);
				return 1;
		}
	}


	if(argc != 2){
		fprintf(stderr, "Especifique una cadena de caracteres sin espacios...\n");
		fprintf(stderr, "uso: %s <cadena_caracteres>\n", argv[0]);
		fprintf(stderr, "     %s -h\n", argv[0]);
		return 1;
	}

	input_string = argv[1];
	
        
	/************************************************/

	/*TODO: Descargar sha256.c y sha256.h y crear la librería libsha256 */
	/*TODO: Usar los ejemplos en sha256_test.c como referencia para generar el hash 256 del texto ingresado */
	/*TODO:Remover la línea de abajo y reemplazarla con el código para convertir
	 * input_string a su respectivo hash sha256. */
	output_string = input_string;
	SHA256_CTX ctx;
    	BYTE hash[SHA256_BLOCK_SIZE];
	sha256_init(&ctx);
	sha256_update(&ctx, (const BYTE*)output_string, strlen(output_string));
	sha256_final(&ctx, hash);
    	print_hex(hash, SHA256_BLOCK_SIZE);
	printf("\n");


	/*TODO: Usar print_hex para mostrar en consola el hash SHA256 en modo texto */
	/*printf("%s\n", output_string);*/

	/************************************************/	
}