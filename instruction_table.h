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

void add_instruction(char inst_name[], int op1, int op2, int op3);
void print_inst_tab();

#endif