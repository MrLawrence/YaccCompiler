/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_TURTLE_TAB_H_INCLUDED
# define YY_YY_TURTLE_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    GO = 258,
    SEMICOLON = 259,
    NORTH = 260,
    SOUTH = 261,
    WEST = 262,
    EAST = 263,
    TURNLEFT = 264,
    TURNRIGHT = 265,
    TURN = 266,
    THICKNESS = 267,
    NUMBER = 268,
    FLOAT = 269,
    ID = 270,
    PLUS = 271,
    MINUS = 272,
    TIMES = 273,
    OPEN = 274,
    CLOSE = 275,
    EULER = 276,
    EXP = 277,
    SIN = 278,
    ASSIGN = 279,
    VAR = 280,
    BEG = 281,
    END = 282,
    DO = 283,
    WHILE = 284,
    LESS = 285,
    GREATER = 286,
    EQUAL = 287,
    TRUE = 288,
    FALSE = 289,
    AND = 290,
    NOT = 291,
    OR = 292,
    IF = 293,
    THEN = 294,
    ELSE = 295,
    PROC = 296
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 21 "turtle.y" /* yacc.c:1909  */
 int i; float f; node *n; 

#line 99 "turtle.tab.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_TURTLE_TAB_H_INCLUDED  */
