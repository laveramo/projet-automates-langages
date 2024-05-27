#include "instruction_table.h"

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
    printf("\t\tASM\t\t\t\n");
    for(int i = 0; i < inst_cont; i ++) {
        printf("%s\t", tab_instruct[i].ins_name);
        printf("%d\t", tab_instruct[i].op1);
        printf("%d\t", tab_instruct[i].op2);
        printf("%d\n", tab_instruct[i].op3);
        printf("-------------------------------------------\n");
    } 
}