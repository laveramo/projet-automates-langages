#include "symbol_table.h"
#include "instruction_table.h"

#define MAX_SYMBOLS 255
#define RESET   "\033[0m"      /* Reset */
#define RED     "\033[31m"      /* Red */
#define BOLDMAGENTA "\033[1m\033[35m"      /* Bold Magenta */

struct symbol tab_symbol[MAX_SYMBOLS];

int cont = 0;
int scope = 0;
int crrnt_scope = 0;
int total_tmp = 0;

int search_symbol(char name[]) {
    for(int i = cont-1; i >= 0; i --) {
        // Compares if the symbol name is equal to the name being searched in the symbol table (strcmp returns 0 if they are equal)
        if(strcmp(tab_symbol[i].id_name, name)==0) {
            return i;
        }
    }
    return -1;
}

int search_symbol_by_scope(char name[], int scope) {
    for(int i = cont-1; i >= 0; i --) {
        // Compares if the symbol name is equal to the name being searched in the symbol table (strcmp returns 0 if they are equal)
        if(strcmp(tab_symbol[i].id_name, name)==0 && tab_symbol[i].var_scope == scope) {
            return i;
        }
    }
    return -1;
}

void add_symbol(char name[], int val) {
    int index = search_symbol(name);

    if(cont == MAX_SYMBOLS ) {
        printf(RED "Error: " RESET);
        printf("Maximum number of symbols reached.\n");
        exit(1);
    }

    if(index == -1) {
        if(strcmp(name, "tmp") == 0){

            // Check if there is a variable already declared for the tmp symbol
            if(strcmp(tab_symbol[cont-1].id_name, "") == 0) {
                printf(RED "Error: " RESET);
                printf("Variable not declared.\n");
                exit(1);
            }
            
            set_tmp_symbol(name);
            add_instruction("AFC", total_tmp, val, 0);
        }
        else {
            strcpy(tab_symbol[cont].id_name, name);
            tab_symbol[cont].var_scope = scope;
        }
    } 
    else if(strcmp(name, "tIF") == 0) {
        strcpy(tab_symbol[cont].id_name, name);
    }
    tab_symbol[cont].value = val;
    
    cont++;
}

char * set_tmp_symbol(char name[]) {
    char * tmpname = malloc(12 * sizeof(char));

    total_tmp = 1;
    for(int i = 0; i < cont; i++) {
        if(strstr(tab_symbol[i].id_name, "tmp") != NULL) {
            total_tmp++;
        }
    }

    snprintf(tmpname, 12, "tmp%d", total_tmp);
    strcpy(tab_symbol[cont].id_name, tmpname);
    tab_symbol[cont].var_scope = scope;
    return tmpname;
}

void copy_to_tmp(char name[]) {
    int var_index = search_symbol(name);

    if(var_index != -1) {
        set_tmp_symbol(name);
        add_instruction("COP", total_tmp, var_index, 0);
        cont++;
    } else {
        printf(RED "Error: " RESET);
        printf("Variable %s not declared\n", name);
    }
}

void copy_to_last_tmp(char name[]) {
    int var_index = search_symbol(name);

    // The variable was found and the last symbol is a tmp symbol
    if(var_index != -1 && (strstr(tab_symbol[cont-1].id_name, "tmp") != NULL)) {
        if(crrnt_scope == scope) {
            add_instruction("COP", var_index, total_tmp, 0);
            cont--;

        } else {
            set_tmp_symbol(name);
            add_instruction("COP", total_tmp-1, 0, 0);
            cont++;
        }
    }
}

void if_statement() {
    set_tmp_symbol("tmp");
    add_instruction("COP", total_tmp, 0, 0);
    add_instruction("JMPF", total_tmp, 0, 0);

    set_jump(cont);
    add_symbol("tIF", get_inst_cont());

    scope++;
    crrnt_scope = scope;
}

void end_if() {
    int jump_index = get_inst_jump(search_symbol("tIF"));
    set_jump(jump_index-1);

    cont--;
    scope--;
}

// TODO: Test this function
void end_if_else() {
    printf("End if else\n");
    int jump_index = get_inst_jump(search_symbol_by_scope("tIF", crrnt_scope));
    set_jump(jump_index-1);

    cont--;
    scope++;
}

void while_statement() {
    scope++;
    crrnt_scope = scope;

    set_tmp_symbol("tmp");
    add_instruction("COP", total_tmp, 0, 0);
    add_instruction("JMPF", total_tmp, 0, 0);

    set_jump(cont);
    add_symbol("tWHILE", get_inst_cont());
}

void end_while() {
    int jump_index = get_inst_jump(search_symbol("tWHILE"));
    set_jump(jump_index-1);

    add_instruction("JMP", 0, jump_index, 0);

    cont--;
    scope--;
}

void operation(char op[]){
    add_instruction(op,cont-2,cont-2,cont-1);
    cont--;
}

int get_inst_jump(int inst_index) {
    return tab_symbol[inst_index].value;
}


void print_tab() {
    printf(BOLDMAGENTA "\tPDA Stack\n" RESET);
    printf("|---------------------------|\n");
    printf("| var     |  value  | scope |\n");
    printf("|---------------------------|\n");
    for (int i = 0; i < cont; i++) {
        char * var_name = tab_symbol[i].id_name;
        int var_value = tab_symbol[i].value;
        int var_scope = tab_symbol[i].var_scope;

        printf("| %-7s |  %5d  | %5d |\n", var_name, var_value, var_scope);
    }
    printf("|---------------------------|\n");
}
