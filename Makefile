NAME = sha256
DEPS = $(NAME).h
SLIB = lib$(NAME).a
DLIB = lib$(NAME).so
EXEC = hash256

CFLAGS := -L.

.PHONY: static dynamic clean
static: $(SLIB) $(EXEC)

dynamic:

$(EXEC): main.c
	gcc -static -o $(EXEC) main.c $(SLIB) -L.

$(SLIB): sha256.c
	gcc -c sha256.c
	ar rcs $(SLIB) sha256.o	

clean:
	rm -rf $(EXEC) *.o $(SLIB) $(DLIB)