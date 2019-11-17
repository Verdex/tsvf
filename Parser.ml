
open Data

exception ParseError of string

let must v = 
    match v with
    | true -> ()
    | false -> raise (ParseError "failed must")

let e_symbol_with name input = 
    match input#current with
    | Symbol n when name = n -> input#move_next
    | _ -> raise (ParseError (Printf.sprintf "expected symbol with value: %s" name))

let e_symbol input =
    match input#current with
    | Symbol n -> (input#move_next, n)
    | _ -> raise (ParseError "expected symbol")

let e_mod input = 
    e_symbol_with "mod" input
    ; 
    let (_, mod_name) = e_symbol input in
    
    { name = mod_name
    ; type_defs = []
    ; opens = []
    ; lets = []
    }

let parse (input : < current : token 
                   ; move_next : bool
                   ; look_ahead : int -> token option >) =

    must input#move_next
    ; 
    Module (e_mod input)



