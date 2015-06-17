%{
#include <stdio.h>
#include "symtab.h"
#include <stdlib.h>
extern int yylineno;
%}

%token GO
%token SEMICOLON
%token NORTH SOUTH WEST EAST
%token TURNLEFT TURNRIGHT
%token TURN THICKNESS
%token <i> NUMBER
%token <f> FLOAT
%token <n> ID
%token PLUS MINUS TIMES OPEN CLOSE EULER EXP SIN
%token ASSIGN VAR
%token BEG END DO WHILE LESS GREATER EQUAL TRUE FALSE  AND NOT OR IF THEN ELSE
%token PROC

%union { int i; float f; node *n; }

%error-verbose
%%

program: head decllist stmtlist tail;

head:  { printf("%%!PS\n" "100 100 translate\n" "/angle 0 def\n" "newpath\n" "0 0 moveto\n"); };
tail: { printf("stroke\n"); };

stmtlist: ;
stmtlist: stmtlist stmt;
decllist: ;
decllist: decllist decl;


decl: VAR ID SEMICOLON { $2 -> declared = 1; 
						printf("/tlt%s 0 def\n", $2 -> symbol); };
decl: VAR ID ASSIGN expr SEMICOLON { printf(" /tlt%s exch def\n", $2 -> symbol); $2 -> declared = 1; };

decl: PROC ID { $2 -> declared = 1; printf("/tlt%s {\n", $2 -> symbol); } OPEN CLOSE
		BEG
		decllist
		stmtlist
		END  { printf("} def\n"); };

stmt: ID OPEN CLOSE SEMICOLON { if (!$1 -> declared) {yyerror("Undeclared Function");}
				printf("tlt%s ", $1 -> symbol); };

stmt: error SEMICOLON { yyerror("broken statement"); };
stmt: BEG stmtlist error END { yyerror("broken statement"); };

stmt: WHILE { printf("{ "); } bool { printf("not { exit } if\n"); } DO stmt { printf("} loop\n"); };
stmt: BEG { scope_open(); printf("4 dict begin\n"); }
		decllist
		stmtlist 
		END { scope_close(); printf("end\n"); };

stmt: IF bool { printf("not { exit } if\n"); } THEN decllist stmtlist;
stmt: GO SEMICOLON{ printf("50 0 rlineto\n"); };
stmt: GO expr SEMICOLON{ printf("dup 0 rlineto\n"); }
stmt: NORTH SEMICOLON{ printf("90 angle sub rotate /angle 90 def\n"); };
stmt: SOUTH SEMICOLON{ printf("270 angle sub rotate /angle 270 def\n"); };
stmt: WEST SEMICOLON{ printf("180 angle sub rotate /angle 180 def\n"); };
stmt: EAST SEMICOLON{ printf("0 angle sub rotate /angle 0 def\n"); };
stmt: TURNLEFT SEMICOLON{ printf("90 rotate\n"); };
stmt: TURNRIGHT SEMICOLON{ printf("270 rotate\n"); };
stmt: TURN expr SEMICOLON { printf("dup rotate /angle exch angle add def\n"); };
stmt: THICKNESS NUMBER SEMICOLON { printf("%d setlinewidth\n", $2); };
stmt: ID ASSIGN expr SEMICOLON { if (!$1 -> declared) yyerror("Undeclared Variable");	
								printf(" /tlt%s exch store\n", $1 -> symbol); };


bool: bool OR bool1 { printf("or "); };
bool: bool1;

bool1: bool1 AND bool2 { printf("and "); };
bool1: bool2

bool2: NOT bool3 { printf("not "); };
bool2: bool3

bool3: expr LESS expr { printf("lt "); };
bool3: expr GREATER expr { printf("gt "); };
bool3: expr EQUAL expr { printf("eq "); };
bool3: TRUE { printf("true "); };
bool3: FALSE { printf("false "); };
bool3: OPEN bool CLOSE


expr: prod;
expr: expr PLUS prod { printf("add "); };
expr: expr MINUS prod { printf("sub "); };

//expr: SIN OPEN expr CLOSE { printf("sin(%d) ", $1); };

prod: exp;
prod: prod TIMES exp { printf("mul "); };

exp: atomic;
exp: atomic EXP exp { printf("exp "); };

atomic: NUMBER { printf("%d ", $1); };
atomic: FLOAT { printf("%f ", $1); };
atomic: OPEN expr CLOSE;
atomic: OPEN error CLOSE { yyerror("broken expression"); };
atomic: EULER { printf("2.71828 "); };
atomic: ID { if (!$1 -> declared) {
				yyerror("Undeclared Variable");
				}
				printf("tlt%s ", $1 -> symbol); };
%%

int yyerror(char *msg) {
	fprintf(stderr, "ERROR near line %d: %s \n", yylineno, msg);
	exit(1);
}

int main(void) {
	yydebug=0;
	yyparse();
	return 0;
}
