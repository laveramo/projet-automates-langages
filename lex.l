%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "y.tab.h"
%}


%option noyywrap
%option noinput
%option nounput


%%
   
"if"     { return tIF; }
"else"   { return tELSE; }
"while"  { return tWHILE; }
"print"  { return tPRINT; }
"return" { return tRETURN; }
"int"    { return tINT; }
"void"   { return tVOID; }


"+"       { return tADD; }
"-"       { return tSUB; }
"*"       { return tMUL; }
"/"       { return tDIV; }
"<"       { return tLT; }
">"       { return tGT; }

  
"!="      { return tNE; }
"=="      { return tEQ; }
">="      { return tGE; }
"<="      { return tLE; }
 "="      { return tASSIGN; }
"&&"      { return tAND; }
"||"      { return tOR; }
"!"       { printf("tNOT\n"); }
"{"       { return tLBRACE; }
"}"       { return tRBRACE; }
"("       { return tLPAR; }
")"       { return tRPAR; }



";"      { return tSEMI; }
","     { return tCOMMA; }



[_a-zA-Z][a-zA-Z0-9_]*      { return tID; }
[0-9]+             { /* long int number = strtol(yytext, NULL, 0);
                    return("tNB: '%ld[0x%lx]'\n", number, number); */
                    return tNB; } 
0x[0-9A-Fa-f]+     { /*long int number = strtol(yytext, NULL, 0);
                    return("tNB: '%ld[0x%lx]'\n", number, number);*/
                    return tNB;  } 


\/\/[^\n]*|\/\*([^*]|\*+[^*/])*\*+\/ {/* pour ignorer les commentaires */ }
[ \t\n]+      {/*let the whitespace pass*/}
. {printf( "tERROR\n"); }
%%

