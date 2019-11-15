
open Data

exception ParseError of string

val parse : < current : token 
            ; move_next : bool
            ; look_ahead : int -> token option >
            -> ast

