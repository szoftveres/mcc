OBJDIR = .
SRCDIR = .
INCLUDE = -I lex
OUTDIR = .

## General Flags
PROGRAM = mcc
CC = gcc
LD = gcc
CFLAGS = -Wall -O0 $(INCLUDE)

## Objects that must be built in order to link
OBJECTS = $(OBJDIR)/parser.o\
          $(OBJDIR)/sym.o\

SUBDIRS = lex
.PHONY : $(SUBDIRS)

## Build both compiler and program
all: $(PROGRAM)

$(SUBDIRS):
	git submodule update --init --recursive
	$(MAKE) -C $@

## Compile source files
$(OBJDIR)/%.o : $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c -o $(OBJDIR)/$*.o $< 

## Link object files to build the compiler
$(PROGRAM): $(SUBDIRS) $(OBJECTS)
	ar rcs $(PROGRAM).a $(OBJECTS)

clean:
	-rm -rf $(OBJECTS) $(OUTDIR)/$(PROGRAM) 
	for dir in $(SUBDIRS); do $(MAKE) clean -C $$dir; done


