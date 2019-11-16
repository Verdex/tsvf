
type token = 
    | String of string
    | Number of string
    | Symbol of string
    | RParen
    | LParen
    | RCurl
    | LCurl
    | Orbar
    | Colon
    | SemiColon
    | RAngle
    | LAngle
    | Comma
    | RightArrow 
    | Equal 

type type_def = {ikky: string } 
type let_expr = {blah : string}

type m = { name : string
         ; type_defs : type_def list
         ; lets : let_expr list
         ; opens : string list 
         }



type ast = 
    | Module of m 
