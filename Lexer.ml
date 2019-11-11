
open Data

exception LexError of int * char * string

let lex ( reader : < current : char
          ; index : int
          ; move_next : bool
          ; look_ahead : int -> char option > )
          
          = []


