GRM=parser.y
LEX=lex.l
BIN=parser

CC=gcc
CFLAGS=-Wall -g

OBJ=y.tab.o lex.yy.o symbol_table.o instruction_table.o

all: $(BIN)


%.o: %.c symbol_table.h instruction_table.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

y.tab.c: $(GRM)
	yacc -d $<

lex.yy.c: $(LEX)
	flex $<

$(BIN): $(OBJ)
	$(CC) $(CFLAGS) $(CPPFLAGS) $^ -o $@

clean:
	rm $(OBJ) y.tab.c y.tab.h lex.yy.c

