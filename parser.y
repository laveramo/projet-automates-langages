%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

int yylex(void);
void yyerror(char *s);

typedef struct symbol {
    char * id_name;
    // int val;
    // char type;
};

int cont = 0;

struct symbol tab_symbol[255];

// Busca un símbolo en la tabla de símbolos
bool search_symbol(char * name) {
    int i;
    for(i = cont-1; i >= 0; i --) {
        // Compara si el nombre del símbolo es igual al nombre que se busca en la tabla de símbolos (strcmp devuelve 0 si son iguales)
        if(strcmp(tab_symbol[i].id_name, name)==0) {
            return true;
        }
    }
    return false;
}

// Añade símbolo a la tabla de símbolos
void add_symbol(char * name) {
    if(cont > 0) {
        if(!search_symbol(name)) {
            tab_symbol[cont].id_name = name;
        }
    } else {
        tab_symbol[0].id_name = name;
    }
    cont++;
}


%}


%union {
    int ival;
    char * tname;
}

/* Definición de tokens */
%token tVOID tINT tLPAR tRPAR tCOMMA tLBRACE tRBRACE tIF tELSE tSEMI tAND tOR tWHILE tRETURN tPRINT tNOT
%token <tname> tID
%token <ival> tNB

/* 'left' para que asocie de izquierda a derecha -> 2+3+4 = (2+3)+4 */
%left tLT tGT tASSIGN tNE tGE tLE tEQ
%left tADD tSUB
%left tMUL tDIV

/* Inicio del programa */
%start program

%%

program : fun | program fun ;

fun : void_fun | int_fun ;

void_fun : tVOID tID tLPAR params tRPAR fun_body;

int_fun : tINT tID tLPAR params tRPAR fun_body;

fun_body : tLBRACE instructions tRBRACE
    | tLBRACE tRBRACE 
    | tLBRACE instructions return_instruction tRBRACE
    ;

params : /* empty */ | param | params tCOMMA param | tVOID ;

param : tINT tID ;

instructions : instruction
    | instruction instructions
    ;

instruction : assign_instruction
    | declaration_instruction
    | if_instruction
    | while_instruction
    | print_instruction
    ;

item : tID { if(!search_symbol($1)) printf("Variable '%s' not declared.\n", $1); }
| tNB ;

expression : item
    | expression tADD expression
    | expression tSUB expression
    | expression tMUL expression
    | expression tDIV expression
    | tLPAR expression tRPAR
    | item tLT item
    | item tGT item
    | item tASSIGN item
    | item tNE item
    | item tGE item
    | item tLE item
    | item tEQ item
    | item tAND item
    | item tOR item
    | tNOT tLPAR expression tRPAR
    ;

assign_instruction : tID tASSIGN expression tSEMI
    | tID tASSIGN fun_call tSEMI
;

declaration_options : tID { add_symbol($1); }
    | tID tCOMMA declaration_options { add_symbol($1); }
    ;

declaration_instruction : tINT declaration_options tSEMI
    | tINT declaration_options tASSIGN expression tSEMI
    | tINT declaration_options tASSIGN fun_call tSEMI
    ;

fun_call : tID tLPAR fun_call_params tRPAR ;

fun_call_params : /* empty */ | expression | fun_call_params tCOMMA expression ;

if_instruction : tIF tLPAR expression tRPAR fun_body
    | tIF tLPAR expression tRPAR fun_body tELSE if_instruction
    | tIF tLPAR expression tRPAR fun_body tELSE fun_body
    ;

while_instruction : tWHILE tLPAR expression tRPAR fun_body
    ;

return_instruction : tRETURN expression tSEMI;

print_instruction : tPRINT tLPAR expression tRPAR tSEMI;

%%

void yyerror(char *s) { fprintf(stderr, "%s\n", s); }

int main(void) {
  printf("Parser\n"); // yydebug=1;
  yyparse();
  return 0;
}