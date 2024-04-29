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

// adds a temp variable and to get the value of an already initialized variable
void copy_symbol(char name[]);

// copy a symbol already created into a temp variable
void  copy_last_temp(char name[]);

// operation of the last 2 temp variables (according to op value), free the last one
void operation(char op[]);



int set_scope(int scope);

void print_tab();

#endif
 