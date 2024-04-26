#include "symbol_table.h"
#include "instruction_table.h"

struct symbol tab_symbol[255];

int cont = 0;
int scope = 0;

bool search_symbol(char name[]) {
    for(int i = cont-1; i >= 0; i --) {
        // Compara si el nombre del símbolo es igual al nombre que se busca en la tabla de símbolos (strcmp devuelve 0 si son iguales)
        if(strcmp(tab_symbol[i].id_name, name)==0) {
            return true;
        }
    }
    return false;
}

int get_index(char name[]) {
    for(int i = cont-1; i >= 0; i --) {
        // Compara si el nombre del símbolo es igual al nombre que se busca en la tabla de símbolos (strcmp devuelve 0 si son iguales)
        if(strcmp(tab_symbol[i].id_name, name)==0) {
            return i;
        }
    }
    return -1;
}

void add_symbol(char name[], int val) {
    if(cont > 0) {
        if(!search_symbol(name)) {
            if(strcmp(name, "tmp")==0) {
                char tmpname[12];
                snprintf(tmpname, 12, "tmp%d", cont);
                strcpy(tab_symbol[cont].id_name, tmpname);
                add_instruction("AFC", cont, val, 0);
            }
            else strcpy(tab_symbol[cont].id_name, name);
            tab_symbol[cont].var_scope = scope;
        }
    } else {
        strcpy(tab_symbol[0].id_name, name);
        tab_symbol[0].var_scope = scope;
    }
    cont++;
    print_tab();
    print_inst_tab();
}


void copy_last_temp(char name[]){
    if(search_symbol(name)) {
        add_instruction("COP",get_index(name),cont-1,0);
        cont--;
        print_tab();
        print_inst_tab();
    }
    
    
}

int set_scope(int scope) {return 1;}

void print_tab() {
    printf("symbol table\n");
    for(int i = 0; i < cont; i ++) {
        printf("%s\n", tab_symbol[i].id_name);
    } 
}
