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
* @brief Adds an instruction to the instruction table
* @param inst_name Name of the instruction
* @param op1 Operand 1
* @param op2 Operand 2
* @param op3 Operand 3
*/
void add_instruction(char inst_name[], int op1, int op2, int op3);

/*
* @fn get_inst_jump
* @brief Returns the jump of an instruction (which can be translated to the index of the instruction)
* @return Jump of the instruction (index of the instruction)
*/
int get_inst_cont();

/*
* @fn get_inst_jump
* @brief Sets the jump of an instruction
* @param inst_index Index of the instruction
*/
void set_jump(int inst_index);

/*
* @fn print_inst_tab
* @brief Prints the instruction table
*/
void print_inst_tab();

#endif