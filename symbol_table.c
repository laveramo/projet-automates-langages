#include "symbol_table.h"
#include "instruction_table.h"

struct symbol tab_symbol[255];

int cont = 0;
int scope = 0;

int search_symbol(char name[]) {
    for(int i = cont-1; i >= 0; i --) {
        // Compara si el nombre del símbolo es igual al nombre que se busca en la tabla de símbolos (strcmp devuelve 0 si son iguales)
        if(strcmp(tab_symbol[i].id_name, name)==0) {
            return i;
        }
    }
    return -1;
}

void add_symbol(char name[], int val) {
    if(search_symbol(name) == -1) {
        if(strcmp(name, "tmp") == 0) {
            set_tmp_symbol(name);
            add_instruction("AFC", cont, val, 0);
        }
        else strcpy(tab_symbol[cont].id_name, name);
        tab_symbol[cont].var_scope = scope;
    } 
    cont++;
}

char * set_tmp_symbol(char name[]) {
    char * tmpname = malloc(12 * sizeof(char));
    snprintf(tmpname, 12, "tmp%d", cont);
    strcpy(tab_symbol[cont].id_name, tmpname);
    return tmpname;
}

void copy_to_tmp(char name[]) {
    int var_index = search_symbol(name);

    if(var_index != -1) {
        set_tmp_symbol(name);
        add_instruction("COP", cont, var_index, 0);
        cont++;
    } else {
        printf("Error: Variable %s no declarada\n", name);
    }
}

void copy_to_last_tmp(char name[]) {
    int var_index = search_symbol(name);

    if(var_index != -1) {
        add_instruction("COP", var_index, cont-1, 0);
        cont--;
    }
    print_inst_tab();
}

void operation(char op[]){
    print_tab();
    add_instruction(op,cont-2,cont-2,cont-1);
    cont--;
    print_inst_tab();
}


int set_scope(int scope) {return 1;}

void print_tab() {
    printf("\t\tPDA Stack\t\t\t\n");
    for(int i = 0; i < cont; i ++) {
        printf("tID\t");
        printf("%s\n", tab_symbol[i].id_name);
        printf("-------------------------------------------\n");
    } 
}
