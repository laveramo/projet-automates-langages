%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
%}


%option noyywrap
%option noinput
%option nounput


%%
   


"if"                       { printf("tIF\n"); }
"else"                     { printf("tELSE\n"); }
"while"                    { printf("tWHILE\n"); }
"print"                    { printf("tPRINT\n"); }
"return"                   { printf("tRETURN\n"); }
"int"                      { printf("tINT\n"); }
"void"                     { printf("tVOID\n"); }


"+"       {printf("tADD\n");}
"-"       {printf("tSUB\n");}
"*"       {printf("tMUL\n");}
"/"       {printf("tDIV\n");}
"<"       {printf("tLT\n");}
">"       {printf("tGT\n");}

  
"!="      {printf("tNE\n");}
"=="      {printf("tEQ\n");}
">="      {printf("tGE\n");}
"<="      {printf("tLE\n");}
 "="      {printf("tASSIGN\n");}
"&&"      {printf("tAND\n");}
"||"      {printf("tOR\n");}
"!"       {printf("tNOT\n");}
"{"       {printf("tLBRACE\n");}
"}"       {printf("tRBRACE\n");}
"("       {printf("tLPAR\n");}
")"       {printf("tRPAR\n");}



";"      {printf("tSEMI\n");}
","     {printf("tCOMMA\n");}



[a-zA-Z][a-zA-Z0-9_]*      { printf("tID: '%s'\n",yytext); }
[0-9]+             { long int number = strtol(yytext, NULL, 0);
                    printf("tNB: '%ld[0x%lx]'\n", number, number); } 
0x[0-9A-Fa-f]+     { long int number = strtol(yytext, NULL, 0);
                    printf("tNB: '%ld[0x%lx]'\n", number, number);  } 


\/\/[^\n]*|\/\*([^*]|\*+[^*/])*\*+\/ {/* pour ignorer les commentaires */ }
[ \t\n]+      {/*let the whitespace pass*/}
. {printf( "tERROR\n"); } 
%%


int main(int argc, char **argv) {
  yylex();
}
