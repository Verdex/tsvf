
all: Data.cmi Lexer.cmx Parser.cmx Main.cmx
	ocamlopt -o tsvf Lexer.cmx Parser.cmx Main.cmx

Main.cmx:
	ocamlopt -c Main.ml

Parser.cmx:
	ocamlc -c Parser.mli
	ocamlopt -c Parser.ml

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

