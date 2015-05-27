all: turtle simple.ps

lex.yy.c: turtle.l
	flex turtle.l

turtle.tab.c: turtle.y
	bison -d -t -v turtle.y

turtle.tab.h: turtle.y
	bison -d -t -v turtle.y

turtle: lex.yy.c turtle.tab.c turtle.tab.h symtab.h symtab.c
	gcc lex.yy.c turtle.tab.c symtab.c -lfl -o turtle

simple.ps: simple.t turtle
	./turtle < simple.t > simple.ps

clean:
	rm -f lex.yy.c turtle.tab.c turtle.tab.h
	rm -f turtle
	rm -f simple.ps
	rm -f *~