
open Data

exception LexError of int * char * string

let lex ( input : < current : char
                  ; index : int
                  ; move_next : bool
                  ; look_ahead : int -> char option > ) =

    let ret = ref [] in
    while input#move_next do
        match input#current with
        | c when c is_whitespace c -> ()
        | '(' -> ret := LParen :: !ret
        | ')' -> ret := RParen :: !ret
        | _ -> raise (LexError (input#index, input#current, "Unknown character encountered"))
    done
    ; List.rev !ret

