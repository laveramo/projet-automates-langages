%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
void yyerror(char *s);
%}

%token tVOID tINT tID tLPAR tRPAR tCOMMA tLBRACE tRBRACE

 /* rules */
%%

Prog : Fun Prog
    | Fun
    ;

Fun : tINT tID tLPAR Params tRPAR Body
    | tVOID tID tLPAR Params tRPAR Body
    ;

Params : ParamsA

ParamsA : 
    | tVOID
    | tINT tID ParamsB
    ;

ParamsB :
    | tCOMMA tINT tID ParamsB
    ;

Body : tLBRACE Code tRBRACE
    ;

Code :
    ;
%%

void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
  printf("Parser\n"); // yydebug=1;
  yyparse();
  return 0;
}