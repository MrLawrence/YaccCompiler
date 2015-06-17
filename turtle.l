%{
#include "symtab.h"
#include "turtle.tab.h"
%}	
%option yylineno
%%

GO	return GO;
;	return SEMICOLON;
, return KOMMA;
NORTH	return NORTH;
SOUTH	return SOUTH;
WEST	return WEST;
EAST	return EAST;
TURNLEFT return TURNLEFT;
TURNRIGHT return TURNRIGHT;
TURN return TURN;
THICKNESS return THICKNESS;
BEGIN	return BEG;
END		return END;
DO 	return DO;
WHILE return WHILE;
AND return AND;
OR return OR;
NOT return NOT;
\< return LESS;
\> return GREATER;
== return EQUAL;
TRUE return TRUE;
FALSE return FALSE;
IF return IF;
THEN return THEN;
ELSE return ELSE;
\+	return PLUS;
\-	return MINUS;
\*	return TIMES;
\(  return OPEN;
\)	return CLOSE;
e   return EULER;
\^  return EXP;
sin return SIN;
=	return ASSIGN;
VAR return VAR;
PROCEDURE return PROC;

[a-zA-Z]+	{	yylval.n = lookup(yytext); 
				if (yylval.n == NULL) {yylval.n = insert(yytext);}
				return ID;
			}
[0-9]+	yylval.i=atoi(yytext); return NUMBER;
[0-9]+\.[0-9]+	yylval.f=atof(yytext); return FLOAT;
[[:space:]]+	;
.	yyerror("Unexpected Character");

%%
