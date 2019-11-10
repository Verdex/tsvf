
all: data.cmi
	ocamlopt -o tsvf 

main.cmx:
	ocamlopt -c main.ml

data.cmi:
	ocamlopt -c data.mli

clean:
	rm -rf *.cmi
	rm -rf *.cmx
	rm -rf *.o
	rm -rf tsvf

