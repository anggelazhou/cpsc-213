CFLAGS += -std=gnu11 -g -I..
MAIN_EXE = main
MAIN_OBJ = main.o list.o tree.o str_element.o int_element.o ../refcount.o
SORT_EXE = sortmain
SORT_OBJ = sortmain.o str_element.o int_element.o ../refcount.o

EXES = $(MAIN_EXE) $(SORT_EXE)
OBJS = $(MAIN_OBJ) $(SORT_OBJ)

all: $(EXES)

$(MAIN_EXE): $(MAIN_OBJ)
$(SORT_EXE): $(SORT_OBJ)

clean:
	rm -f $(EXES) $(OBJS)
tidy:
	rm -f $(OBJS)

main.o: main.c element.h int_element.h str_element.h list.h tree.h refcount.h
list.o: list.c list.h refcount.h
tree.o: tree.c tree.h refcount.h
str_element.o 
int_element.o 
../refcount.o

