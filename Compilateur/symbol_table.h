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
};

/*
* @fn search_symbol
* @brief Search for a symbol in the symbol table and returns its index, if it doesn't find it returns -1
* @param name Name of the symbol to search
* @return Index of the symbol in the symbol table
*/
int search_symbol(char name[]);

/*
* @fn search_symbol_by_scope
* @brief Search for a symbol in the symbol table by scope and returns its index, if it doesn't find it returns -1
* @param name Name of the symbol to search
* @param scope Scope of the symbol to search
* @return Index of the symbol in the symbol table
*/
int search_symbol_by_scope(char name[], int scope);

/*
* @fn add_symbol
* @brief Adds a symbol to the symbol table
* @param name Name of the symbol
* @param val Value of the symbol
*/
void add_symbol(char name[], int val);

/*
* @fn set_tmp_symbol
* @brief Generates the name of a temporary symbol
* @param name Name of the symbol
*/
char * set_tmp_symbol(char name[]);

/*
* @fn copy_to_tmp
* @brief Copy an existing symbol to a temporary symbol
* @param name Name of the symbol
*/
void copy_to_tmp(char name[]);

/*
* @fn copy_to_last_tmp
* @brief Copy an existing symbol to the last temporary symbol created
* @param name Name of the symbol
*/
void copy_to_last_tmp(char name[]);

/*
* @fn if_statement
* @brief Creates a conditional jump instruction
*/
void if_statement();

/*
* @fn end_if
* @brief Sets the jump of an instruction
*/
void end_if();

/*
* @fn end_if_else
* @brief Sets the jump of an instruction for an else statement
*/
void end_if_else();

/*
* @fn while_statement
* @brief Creates a conditional jump instruction for a while statement
*/
void while_statement();

/*
* @fn end_while
* @brief Sets the jump of an instruction for a while statement
*/
void end_while();

/*
* @fn get_inst_jump
* @brief Devuelve el índice de la instrucción de salto
* @param inst_index Índice de la instrucción
* @return Índice de la instrucción de salto
*/
int get_inst_jump(int inst_index);

/*
* @fn operation
* @brief Detecta la operación a realizar y la guarda en la tabla de instrucciones
* @param op Operación a realizar
*/
void operation(char op[]);

/*
* @fn print_tab
* @brief Imprime la tabla de símbolos
*/
void print_tab();

#endif
 