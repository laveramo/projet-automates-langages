#ifndef INSTRUCTION_TABLE_H
#define INSTRUCTION_TABLE_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

struct instruction {
    char ins_name[3];
    int op1;
    int op2;
    int op3;
};

/*
* @fn add_instruction
* @brief Añade una instrucción a la tabla de instrucciones
* @param inst_name Nombre de la instrucción
* @param op1 Operando 1
* @param op2 Operando 2
* @param op3 Operando 3
*/
void add_instruction(char inst_name[], int op1, int op2, int op3);

/*
* @fn print_inst_tab
* @brief Imprime la tabla de instrucciones
*/
void print_inst_tab();

#endif