
all: Data.cmi Lexer.cmx Main.cmx
	ocamlopt -o tsvf 

Main.cmx:
	ocamlopt -c Main.ml

Lexer.cmx:
	ocamlc -c Lexer.mli
	ocamlopt -c Lexer.ml

Data.cmi:
	ocamlopt -c Data.mli

clean:
	rm -rf *.cmi
	rm -rf *.cmx
	rm -rf *.o
	rm -rf tsvf

