%{
#include "symbol_table.h"
#include "instruction_table.h"

int yylex(void);
void yyerror(char *s);

%}


%union {
    int ival;
    char * tname;
}

/* Definición de tokens */
%token tVOID tINT tLPAR tRPAR tCOMMA tLBRACE tRBRACE tIF tELSE tSEMI tAND tOR tWHILE tRETURN tPRINT tNOT tADD tSUB tMUL tDIV tLT tGT tASSIGN tNE tGE tLE tEQ
%token <tname> tID
%token <ival> tNB

/* 'left' para que asocie de izquierda a derecha -> 2+3+4 = (2+3)+4 */
%left tADD tSUB
%left tMUL tDIV

/* Inicio del programa */
%start program

%type <tname> identifier
%type <ival> number
%type <tname> item expression

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

identifier : tID { $$ = $1; } ;
number : tNB { $$ = $1; } ;

item : identifier
| number {
    char * numStr = malloc(12 * sizeof(char));
    sprintf(numStr, "%d", $1);
    $$ = numStr;
}
;

expression : item
    | expression tADD expression { printf("--- ADD %s %s\n", $1, $3); add_tmp_symbol($1, NULL);  }
    | expression tMUL expression {  printf("--- MUL %s %s\n", $1, $3); add_tmp_symbol($1, NULL);}
    | expression tDIV expression { printf("--- DIV %s %s\n", $1, $3); add_tmp_symbol($1, NULL);}
    | expression tSUB expression { printf("--- SUB %s %s\n", $1, $3); add_tmp_symbol($1, NULL); }
    ;

assert : item tLT item
    | item tGT item
    | item tASSIGN item
    | item tNE item
    | item tGE item
    | item tLE item
    | item tEQ item
    | item tAND item
    | item tOR item
    | tNOT item
;

assign_instruction : identifier tASSIGN expression tSEMI { if(is_valid_num($3)) { add_tmp_symbol($1, $3); } printf("expression: %s\t%s\n", $1, $3); } // { add_tmp_symbol($1, $3); }
    | identifier tASSIGN fun_call tSEMI
;

declaration_options : identifier { add_symbol($1, 0); }
    | declaration_options tCOMMA identifier { add_symbol($3, 0); }
    ;

declaration_instruction : tINT declaration_options tSEMI
    | tINT declaration_options tASSIGN expression tSEMI
    | tINT declaration_options tASSIGN fun_call tSEMI
    ;

fun_call : tID tLPAR fun_call_params tRPAR ;

fun_call_params : /* empty */ | expression | fun_call_params tCOMMA expression ;

if_instruction : tIF tLPAR assert tRPAR fun_body
    | tIF tLPAR assert tRPAR fun_body tELSE if_instruction
    | tIF tLPAR assert tRPAR fun_body tELSE fun_body
    ;

while_instruction : tWHILE tLPAR assert tRPAR fun_body
    ;

return_instruction : tRETURN expression tSEMI;

print_instruction : tPRINT tLPAR expression tRPAR tSEMI;

%%

void yyerror(char *s) { fprintf(stderr, "%s\n", s); }

int main(void) {
    printf("Parser\n"); // yydebug=1;
    yyparse();
    print_tab();
    printf("\n");
    print_inst_tab();
    return 0;
}