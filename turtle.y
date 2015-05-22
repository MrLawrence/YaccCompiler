%{
#include <stdio.h>
#include "symtab.h"
#include <stdlib.h>
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
%token BEG END DO WHILE LESS GREATER EQUAL TRUE FALSE  AND NOT OR IF THEN

%union { int i; float f; node *n; }
%%

program: head stmtlist tail;

head:  { printf("%%!PS\n" "100 100 translate\n" "/angle 0 def\n" "newpath\n" "0 0 moveto\n"); };
tail: { printf("stroke\n"); };

stmtlist: ;
stmtlist: stmtlist stmt;

stmt: WHILE { printf("{ "); } bool { printf("not { exit } if\n"); } DO stmt { printf("} loop\n"); };
stmt: BEG stmtlist END;

stmt: GO SEMICOLON{ printf("50 0 rlineto\n"); };
stmt: GO expr SEMICOLON{ printf("dup 0 rlineto\n"); }
stmt: NORTH SEMICOLON{ printf("90 angle sub rotate /angle 90 def\n");};
stmt: SOUTH SEMICOLON{printf("270 angle sub rotate /angle 270 def\n");};
stmt: WEST SEMICOLON{ printf("180 angle sub rotate /angle 180 def\n");};
stmt: EAST SEMICOLON{printf("0 angle sub rotate /angle 0 def\n");};
stmt: TURNLEFT SEMICOLON{printf("90 rotate\n");};
stmt: TURNRIGHT SEMICOLON{printf("270 rotate\n");};
stmt: TURN expr SEMICOLON { printf("dup rotate /angle exch angle add def\n"); };
stmt: THICKNESS NUMBER SEMICOLON { printf("%d setlinewidth\n", $2); };
stmt: VAR ID ASSIGN expr SEMICOLON { printf(" /tlt%s exch def\n", $2 -> symbol); $2 -> declared = 1; };
stmt: VAR ID SEMICOLON {$2 -> declared = 1; };
stmt: ID ASSIGN expr SEMICOLON { if (!$1 -> declared) {
									yyerror("Undeclared Variable");
									} else {
								printf(" /tlt%s exch def\n", $1 -> symbol);
								}
							};


bool: bool OR bool1 { printf("or "); };
bool: bool1;

bool1: bool1 AND bool2 { printf("and "); };
bool1: bool2

bool2: NOT bool3 { printf("not ");};
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
atomic: EULER { printf("2.71828 "); };
atomic: ID { printf("tlt%s ", $1 -> symbol); };
%%

int yyerror(char *msg) {
	fprintf(stderr, "ERROR: %s \n", msg);
	exit(1);
}

int main(void) {
	yyparse();
	return 0;
}
