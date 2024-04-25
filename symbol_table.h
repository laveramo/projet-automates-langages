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
* @fn add_tmp_symbol
* @brief Añade un símbolo temporal a la tabla de símbolos
* @param name Nombre del símbolo
* @param val Valor del símbolo
*/
void add_tmp_symbol(char name[], char val[]);

int set_scope(int scope);

/*
* @fn is_valid_num
* @brief Comprueba si un número es válido
* @param num Número a comprobar
* @return true si el número es válido, false en caso contrario
*/
bool is_valid_num(char num[]);

/*
* @fn print_tab
* @brief Imprime la tabla de símbolos
*/
void print_tab();

#endif
 