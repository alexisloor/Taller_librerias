NAME = sha256
DEPS = $(NAME).h
SLIB = lib$(NAME).a
DLIB = lib$(NAME).so
EXEC = hash256

CFLAGS := -L.

.PHONY: static dynamic clean
static: $(EXEC)

dynamic:

$(EXEC): main.c sha256.c
	gcc -o $(EXEC) main.c sha256.c

clean:
	rm -rf $(EXEC) *.o $(SLIB) $(DLIB)