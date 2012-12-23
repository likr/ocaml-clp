SOURCES = clp_stubs.c clp.mli clp.ml
RESULT = clp
LIBINSTALL_FILES = $(wildcard *.mli *.cmi *.cma *.cmxa *.a *.so)
CLIBS = Clp CoinUtils
CFLAGS = -Wall -O3
ANNOTATE = yes

all: byte

byte: byte-code-library

opt: native-code-library

install: libinstall

uninstall: libuninstall
	
update: uninstall install

-include OCamlMakefile
