play:
	dune exec bin/main.exe

build:
	dune build

clean: 
	dune clean

zip:
	rm -f prisondash.zip
	zip -r prisondash.zip . -x@exclude.lst

loc:
	ocamlbuild -clean
	cloc --by-file --include-lang=OCaml .