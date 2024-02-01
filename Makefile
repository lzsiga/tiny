CC = gcc

CFLAGS   = -g -W -Wall
CPPFLAGS =
LDFLAGS  = -g

all: tiny tm

tiny: main.o util.o scan.o parse.o symtab.o analyze.o code.o cgen.o
	${CC} ${LDFLAGS} -o $@ $^

main.o: main.c globals.h util.h scan.h parse.h analyze.h cgen.h
	${CC} -c ${CFLAGS} ${CPPFLAGS} main.c

util.o: util.c util.h globals.h
	${CC} -c ${CFLAGS} ${CPPFLAGS} util.c

scan.o: scan.c scan.h util.h globals.h
	${CC} -c ${CFLAGS} ${CPPFLAGS} scan.c

parse.o: parse.c parse.h scan.h globals.h util.h
	${CC} -fno-builtin -c ${CFLAGS} ${CPPFLAGS} parse.c

symtab.o: symtab.c symtab.h
	${CC} -c ${CFLAGS} ${CPPFLAGS} symtab.c

analyze.o: analyze.c globals.h symtab.h analyze.h
	${CC} -c ${CFLAGS} ${CPPFLAGS} analyze.c

code.o: code.c code.h globals.h
	${CC} -c ${CFLAGS} ${CPPFLAGS} code.c

cgen.o: cgen.c globals.h symtab.h code.h cgen.h
	${CC} -c ${CFLAGS} ${CPPFLAGS} cgen.c

clean: 
	rm -f tiny main.o util.o scan.o parse.o symtab.o analyze.o code.o cgen.o lex/lex.yy.c yacc/tiny.tab.c  

tm: tm.c
	${CC} -g ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} tm.c
