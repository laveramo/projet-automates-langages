#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <ctype.h>

struct symbol {
    char id_name[128];
    int var_scope;
    int value;
    // char type;
};

/*
* @fn search_symbol
* @brief Busca un símbolo en la tabla de símbolos y devuelve su índice, si no lo encuentra devuelve -1
* @param name Nombre del símbolo a buscar
* @return Índice del símbolo en la tabla de símbolos
*/
int search_symbol(char name[]);

/*
* @fn add_symbol
* @brief Añade un símbolo a la tabla de símbolos
* @param name Nombre del símbolo
* @param val Valor del símbolo
*/
void add_symbol(char name[], int val);

/*
* @fn set_tmp_symbol
* @brief Genera el nombre de un símbolo temporal
* @param name Nombre del símbolo
*/
char * set_tmp_symbol(char name[]);

/*
* @fn copy_to_tmp
* @brief Copia un símbolo ya existente a un símbolo temporal
* @param name Nombre del símbolo
*/
void copy_to_tmp(char name[]);

/*
* @fn copy_to_last_tmp
* @brief Copia un símbolo ya existente al último símbolo temporal creado
* @param name Nombre del símbolo
*/
void copy_to_last_tmp(char name[]);

int set_scope(int scope);

/*
* @fn print_tab
* @brief Imprime la tabla de símbolos
*/
void print_tab();

#endif
 