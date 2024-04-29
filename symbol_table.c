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
        strcpy(tab_symbol[cont].id_name, name);
        tab_symbol[cont].var_scope = scope;
    
        cont++;
    }
    
}

void add_tmp_symbol(char name[], char val[]) {
    int var_index = search_symbol(name);
    char tmpname[12];
    snprintf(tmpname, 12, "tmp%d", cont);

    // Si el valor es NULL, significa que se está copiando el valor de una variable a un símbolo temporal
    if(val == NULL) {
        printf("val is NULL\t\t %s\t%d\n", name, var_index);
        if(is_valid_num(name)) {
            add_instruction("AFC", cont, atoi(name), 0);
            add_symbol(tmpname, atoi(name));
        } else {
            add_instruction("COP", cont, var_index, 0);
            add_symbol(tmpname, tab_symbol[var_index].value);
        }
    } else {
        add_instruction("AFC", cont, atoi(val), 0);
        add_symbol(tmpname, atoi(val));
        // Decrementa el contador de la tabla de símbolos para 'eliminar' el símbolo temporal que se creó y copiar el valor al símbolo original
        cont--; 
        tab_symbol[var_index].value = atoi(val);
        add_instruction("COP", var_index, cont, 0);
    }
    
}

int set_scope(int scope) {return 1;}

bool is_valid_num(char num[]) {
    for(int i = 0; i < strlen(num); i ++) {
        if(!isdigit(num[i])) {
            return false;
        }
    }
    return true;
}

void print_tab() {
    printf("\t\tPDA Stack\t\t\t\n");
    for(int i = 0; i < cont; i ++) {
        printf("tID\t");
        printf("%s\n", tab_symbol[i].id_name);
        printf("-------------------------------------------\n");
    } 
}
