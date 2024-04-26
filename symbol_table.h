#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

struct symbol {
    char id_name[128];
    int var_scope;
    // char type;
};

// Busca un símbolo en la tabla de símbolos
bool search_symbol(char name[]);

// Añade símbolo a la tabla de símbolos
void add_symbol(char name[], int val);

// copy the last temp variable to corresponding variable (name) and deletes temp variable
void  copy_last_temp(char name[]);

int set_scope(int scope);

void print_tab();

#endif
 