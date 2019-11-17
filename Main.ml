
open Data
open Lexer
open Parser

let read_file name = 
    let chan = open_in name in
    let len = in_channel_length chan in
    let bs = Bytes.create len in
    really_input chan bs 0 len
    ; close_in chan
    ; Bytes.unsafe_to_string bs 

;;

let lex_inputer stuff = object
    val mutable _index = -1
    method move_next = 
        if _index < String.length stuff - 1 then begin
            _index <- _index + 1
            ; true
            end
        else 
            false
    method current = stuff.[_index]  
    method index = _index
    method look_ahead a = 
        if _index + a  < String.length stuff then
            Some stuff.[_index + a]
        else
            None
end

;;

let parse_inputer stuff = object
    val mutable _index = -1
    method move_next = 
        if _index < List.length stuff - 1 then begin
            _index <- _index + 1
            ; true
            end
        else 
            false
    method current = List.nth stuff _index
    method look_ahead a = 
        if _index + a  < List.length stuff then
            Some (List.nth stuff (_index + a))
        else
            None
end

;;

let display_ast a = 
    match a with
    | Module { name = n
             ; opens = os
             ; type_defs = ts
             ; lets = ls
             } -> Printf.sprintf "Mod %s" n
    | _ -> "()"

;;

let prog = 
    let input = read_file "example.t" in
    let lexemes = lex (lex_inputer input) in
    parse (parse_inputer lexemes)

;;


Printf.printf "%s" (display_ast prog)



