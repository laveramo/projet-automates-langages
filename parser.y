%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
void yyerror(char *s);
%}

%token tVOID tINT tID tNB tLPAR tRPAR tCOMMA tLBRACE tRBRACE tIF tELSE tASSIGN tSEMI tNE tEQ tGE tLE tAND tOR tLT tGT tWHILE

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

// int x = 4; declaración

Declaration : tINT tID tASSIGN tINT tSEMI
    | tINT tID tASSIGN tID tSEMI
    ;

// Declaraciones 'If' de una línea ??
If : tIF tLPAR Expression tRPAR tLBRACE Code tRBRACE BodyIf
    ;

BodyIf :
    | tELSE tLBRACE Code tRBRACE
    | tELSE If
    ;

While : tWHILE tLPAR Expression tRPAR Body
    ;

Expression : tNB ExpSymbol tNB
    | tNB ExpSymbol tID
    | tID ExpSymbol tNB
    
    // preguntar sobre el ID en la expresión para verificar que se haya declarado anteriormente
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