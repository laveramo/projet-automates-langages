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

/* Token definition */
%token tVOID tINT tCOMMA tLBRACE tRBRACE tELSE tSEMI tAND tOR tWHILE tRETURN tPRINT tNOT tADD tSUB tMUL tDIV tLT tGT tASSIGN tNE tGE tLE tEQ
%token <tname> tID tIF
%token <ival> tNB tLPAR tRPAR

/* 'left' so that it associates from left to right -> 2+3+4 = (2+3)+4 */
%left tADD tSUB
%left tMUL tDIV

/* Start of the program */
%start program

%type <tname> identifier
%type <ival> number
%type <tname> item item_assert expression

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

item : identifier { copy_to_tmp($1); }
    | number { 
            add_symbol("tmp", $1);
            char * numStr = malloc(12 * sizeof(char));
            sprintf(numStr, "%d", $1);
            $$ = numStr;
        }
    ;

expression : item
    | expression tADD expression { operation("ADD"); }
    | expression tMUL expression { operation("MUL"); }
    | expression tDIV expression { operation("DIV"); }
    | expression tSUB expression { operation("SUB"); }
    ;

item_assert : identifier { copy_to_last_tmp($1); }
    | number {
            add_symbol("tmp", $1);
            char * numStr = malloc(12 * sizeof(char));
            sprintf(numStr, "%d", $1);
            $$ = numStr; }
    ;

assert : item_assert tLT item_assert
    | item_assert tGT item_assert
    | item_assert tASSIGN item_assert
    | item_assert tNE item_assert
    | item_assert tGE item_assert
    | item_assert tLE item_assert
    | item_assert tEQ item_assert
    | item_assert tAND item_assert
    | item_assert tOR item_assert
    | tNOT item_assert
    | item_assert
;

assign_instruction : identifier tASSIGN expression tSEMI { copy_to_last_tmp($1); printf("assign"); }
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

if_instruction : tIF tLPAR assert tRPAR { if_statement(); } fun_body { end_if(); } else_body ;

else_body : /* empty */ | tELSE fun_body { end_if_else(0); } ;

while_instruction : tWHILE tLPAR assert tRPAR { while_statement(); } fun_body { end_while(); }  ;

return_instruction : tRETURN expression tSEMI;

print_instruction : tPRINT tLPAR expression tRPAR tSEMI;

%%

void yyerror(char *s) { fprintf(stderr, "%s\n", s); }

int main(void) {
    printf("==== PARSER ====\n"); // yydebug=1;
    yyparse();
    print_tab();
    printf("\n");
    print_inst_tab();
    return 0;
}