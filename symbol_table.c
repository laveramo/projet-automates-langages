#include "symbol_table.h"

bool search_symbol(char name[]) {
    for(int i = cont-1; i >= 0; i --) {
        // Compara si el nombre del símbolo es igual al nombre que se busca en la tabla de símbolos (strcmp devuelve 0 si son iguales)
        if(strcmp(tab_symbol[i].id_name, name)==0) {
            return true;
        }
    }
    return false;
}

void add_symbol(char name[]) {
    if(cont > 0) {
        if(!search_symbol(name)) {
            if(strcmp(name, "tmp")==0) {
                char tmpname[12];
                snprintf(tmpname, 12, "tmp%d", cont);
                strcpy(tab_symbol[cont].id_name, tmpname);
            }
            else strcpy(tab_symbol[cont].id_name, name);
        }
    } else {
        strcpy(tab_symbol[0].id_name, name);
    }
    cont++;
}
