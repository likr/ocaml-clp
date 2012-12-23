all: byte opt

byte opt install uninstall:
	make -C src $@

clean:
	make -C src clean
	make -C test clean
	rm -rf doc

doc:
	mkdir -p doc/html
	ocamldoc -html -stars -I src -d doc/html src/clp.mli

test:
	make -C test

.PHONY: doc test
