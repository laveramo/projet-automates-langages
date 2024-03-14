%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
void yyerror(char *s);
%}

%token tVOID tINT tNB tID tLPAR tRPAR tCOMMA tLBRACE tRBRACE tNE tEQ tGE tLE tAND tOR tLT tGT tWHILE tIF

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
    | Declaration Code
    | If Code
    | While Code
    ;

Declaration :
    ;

If :
    ;

While : tWHILE tLPAR Expression tRPAR Body
    ;

Expression : tNB ExpSymbol tNB
    | tNB ExpSymbol tID
    | tID ExpSymbol tNB
    | tID ExpSymbol tID
    ;

ExpSymbol : tNE | tEQ | tGE | tLE | tAND | tOR | tLT | tGT
    ;
%%

void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
  printf("Parser\n"); // yydebug=1;
  yyparse();
  return 0;
}