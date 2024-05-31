#include "instruction_table.h"

#define RESET   "\033[0m"      /* Reset */
#define BOLDMAGENTA "\033[1m\033[35m"      /* Bold Magenta */

struct instruction tab_instruct[5000];

int inst_cont = 0;

void add_instruction(char inst_name[], int op1, int op2, int op3) {
    strcpy(tab_instruct[inst_cont].ins_name, inst_name);
    tab_instruct[inst_cont].op1 = op1;
    tab_instruct[inst_cont].op2 = op2;
    tab_instruct[inst_cont].op3 = op3;
    inst_cont++;
}

int get_inst_cont() {
    return inst_cont;
}

void set_jump(int inst_index) {
    if(strstr(tab_instruct[inst_index].ins_name, "JMPF") != NULL) {
        tab_instruct[inst_index].op2 = get_inst_cont();
    }
}

void print_inst_tab() {
    printf(BOLDMAGENTA "\t\t\tASM\n" RESET);
    printf("|---------------------------------------------|\n");
    printf("| Instruction     |  Op1  |   Op2   |   Op3   |\n");
    printf("|---------------------------------------------|\n");
    for (int i = 0; i < inst_cont; i++) {
        char * ins_name = tab_instruct[i].ins_name;
        int op1 = tab_instruct[i].op1;
        int op2 = tab_instruct[i].op2;
        int op3 = tab_instruct[i].op3;

        printf("| %-15s | %-5d | %-7d | %-7d |\n", ins_name, op1, op2, op3);
    }
    printf("|---------------------------------------------|\n");
}