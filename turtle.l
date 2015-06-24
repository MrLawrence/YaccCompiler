%{
#include "symtab.h"
#include "turtle.tab.h"
%}	
%option yylineno
%%

GO			return GO;
;			return SEMICOLON;
, 			return KOMMA;

NORTH		return NORTH;
SOUTH		return SOUTH;
WEST		return WEST;
EAST		return EAST;

TURNLEFT 	return TURNLEFT;
TURNRIGHT 	return TURNRIGHT;
TURN 		return TURN;
THICKNESS 	return THICKNESS;

\{			return BEG;
\}			return END;

do 			return DO;
while 		return WHILE;

&&	 		return AND;
\|\| 		return OR;
not 		return NOT;
\< 			return LESS;
\> 			return GREATER;
== 			return EQUAL;
true 		return TRUE;
false 		return FALSE;

if 			return IF;
then 		return THEN;
else 		return ELSE;

\(  		return OPEN;
\)			return CLOSE;

\+			return PLUS;
\-			return MINUS;
\*			return TIMES;
e   		return EULER;
\^  		return EXP;

=			return ASSIGN;
var 		return VAR;
def 		return PROC;

[a-zA-Z]+	{	yylval.n = lookup(yytext); 
				if (yylval.n == NULL) {yylval.n = insert(yytext);}
				return ID;
			}
[0-9]+	yylval.i=atoi(yytext); return NUMBER;
[0-9]+\.[0-9]+	yylval.f=atof(yytext); return FLOAT;
[[:space:]]+	;
.	yyerror("Unexpected Character");

%%
