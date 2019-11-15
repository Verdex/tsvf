
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

type m = { name : string
         ; type_defs : type_def list
         ; lets : let_expr list
         ; opens : string list 
         }

type type_def = {}
type let_expr = {} 


type ast = 
    | Module of m 
