
open Data

exception LexError of int * char * string

let is_whitespace c =
    match c with 
    | '\t' | '\n' | '\r' | ' ' -> true
    | _ -> false

let is_number c =
    match c with
    | '0' .. '9' -> true
    | _ -> false

let is_number_or_dot c =
    match c with
    | '0' .. '9' -> true
    | '.' -> true
    | _ -> false

let lex_number input =
    let ret = Buffer.create 16 in
    Buffer.add_char ret input#current
    ; while input#move_next && is_number_or_dot input#current do
        Buffer.add_char ret input#current
    done
    ; Number (Buffer.contents ret)

let is_symbol_start c = 
    match c with
    | 'a' .. 'z' | 'A' .. 'Z' | '_' -> true
    | _ -> false

let is_symbol c = 
    match c with
    | '0' .. '9' -> true
    | v when is_symbol_start v -> true
    | _ -> false

let lex_symbol input = 
    let ret = Buffer.create 16 in
    Buffer.add_char ret input#current
    ; while input#move_next && is_symbol input#current do
        Buffer.add_char ret input#current
    done
    ; Symbol (Buffer.contents ret)

let is_line_comment input = input#current = '/' && input#look_ahead 1 = Some '/'

let lex_line_comment input = 
    let not_endline c = 
        match c with
        | '\n' | '\r' -> false
        | _ -> true
    in

    while input#move_next && not_endline input#current do
        ()
    done

let is_block_comment input = input#current = '/' && input#look_ahead 1 = Some '*'

let lex_block_comment input = 
    let not_end_block input = not( input#current = '*' && input#look_ahead 1 = Some '/' )
    in

    let eat _ = ()
    in

    while input#move_next && not_end_block input do
        ()
    done
    ; if input#current <> '*' && input#look_ahead 1 = Some '/' then
        raise (LexError (input#index, input#current, "block comment lexer"))
    ; eat input#move_next

let lex_string input =  
    let ret = Buffer.create 16 in
    while input#move_next && input#current <> '"' do
        Buffer.add_char ret input#current
    done
    ; if input#current <> '"' then
        raise (LexError (input#index, input#current, "string lexer"))
    ; String (Buffer.contents ret)

let lex_right_arrow input =
    if input#look_ahead 1 <> Some '>' then
        raise (LexError (input#index, input#current, "arrow lexer"))
    ; input#move_next
    ; RightArrow
        

let lex ( input : < current : char
                  ; index : int
                  ; move_next : bool
                  ; look_ahead : int -> char option > ) =

    let ret = ref [] in
    while input#move_next do
        match input#current with
        | c when is_whitespace c -> ()
        | _ when is_line_comment input -> lex_line_comment input
        | _ when is_block_comment input -> lex_block_comment input 
        | '(' -> ret := LParen :: !ret
        | ')' -> ret := RParen :: !ret
        | '{' -> ret := LCurl :: !ret 
        | '}' -> ret := RCurl :: !ret 
        | '<' -> ret := LAngle :: !ret
        | '>' -> ret := RAngle :: !ret
        | ',' -> ret := Comma :: !ret 
        | ';' -> ret := SemiColon :: !ret 
        | ':' -> ret := Colon :: !ret 
        | '|' -> ret := Orbar :: !ret
        | '=' -> ret := Equal :: !ret
        | '-' -> ret := lex_right_arrow input :: !ret 
        | c when is_symbol_start c -> ret := lex_symbol input :: !ret 
        | c when is_number c -> ret := lex_number input :: !ret
        | '"' -> ret := lex_string input :: !ret 
        | _ -> raise (LexError (input#index, input#current, "Unknown character encountered"))
    done
    ; List.rev !ret


