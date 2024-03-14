/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    tVOID = 258,                   /* tVOID  */
    tINT = 259,                    /* tINT  */
<<<<<<< HEAD
    tID = 260,                     /* tID  */
    tNB = 261,                     /* tNB  */
=======
    tNB = 260,                     /* tNB  */
    tID = 261,                     /* tID  */
>>>>>>> dc4063c2bea54c1f70efd6996d619ae2edec7c5f
    tLPAR = 262,                   /* tLPAR  */
    tRPAR = 263,                   /* tRPAR  */
    tCOMMA = 264,                  /* tCOMMA  */
    tLBRACE = 265,                 /* tLBRACE  */
    tRBRACE = 266,                 /* tRBRACE  */
<<<<<<< HEAD
    tIF = 267,                     /* tIF  */
    tELSE = 268,                   /* tELSE  */
    tASSIGN = 269,                 /* tASSIGN  */
    tSEMI = 270,                   /* tSEMI  */
    tNE = 271,                     /* tNE  */
    tEQ = 272,                     /* tEQ  */
    tGE = 273,                     /* tGE  */
    tLE = 274,                     /* tLE  */
    tAND = 275,                    /* tAND  */
    tOR = 276,                     /* tOR  */
    tLT = 277,                     /* tLT  */
    tGT = 278                      /* tGT  */
=======
    tNE = 267,                     /* tNE  */
    tEQ = 268,                     /* tEQ  */
    tGE = 269,                     /* tGE  */
    tLE = 270,                     /* tLE  */
    tAND = 271,                    /* tAND  */
    tOR = 272,                     /* tOR  */
    tLT = 273,                     /* tLT  */
    tGT = 274,                     /* tGT  */
    tWHILE = 275,                  /* tWHILE  */
    tIF = 276                      /* tIF  */
>>>>>>> dc4063c2bea54c1f70efd6996d619ae2edec7c5f
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define tVOID 258
#define tINT 259
<<<<<<< HEAD
#define tID 260
#define tNB 261
=======
#define tNB 260
#define tID 261
>>>>>>> dc4063c2bea54c1f70efd6996d619ae2edec7c5f
#define tLPAR 262
#define tRPAR 263
#define tCOMMA 264
#define tLBRACE 265
#define tRBRACE 266
<<<<<<< HEAD
#define tIF 267
#define tELSE 268
#define tASSIGN 269
#define tSEMI 270
#define tNE 271
#define tEQ 272
#define tGE 273
#define tLE 274
#define tAND 275
#define tOR 276
#define tLT 277
#define tGT 278
=======
#define tNE 267
#define tEQ 268
#define tGE 269
#define tLE 270
#define tAND 271
#define tOR 272
#define tLT 273
#define tGT 274
#define tWHILE 275
#define tIF 276
>>>>>>> dc4063c2bea54c1f70efd6996d619ae2edec7c5f

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */