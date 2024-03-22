#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

struct symbol {
    char id_name[128];
    // int * scope;
    // char type;
};

struct symbol tab_symbol[255];

int cont;

// Busca un símbolo en la tabla de símbolos
bool search_symbol(char name[]);

// Añade símbolo a la tabla de símbolos
void add_symbol(char name[]);

#endif
