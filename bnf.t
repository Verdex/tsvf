

mod <<symbol>> {
    open <<symbol>>;
    type <<symbol>>[< <<symbolList>> >] = <<consList>> | <<type>> ;
    let <<symbol>> [: <<type>>] = <<expr>>;
}

<<symbolList>> => <<symbol>> [, <<symbolList>>]
<<consList>> => <<cons>> [| <<consList>> ]
<<cons>> => <<symbol>> 
          | <<symbol>> of <<type>>
<<type>> => <<symbol>>
          | (<<type>>)
          | <<type>> * <<type>>
          | <<symbol>> < <<symbolList>> >
          | <<type>> -> <<type>>
          | ()

<<expr>> => ()
          | (<<expr>>, <<exprList>>)
          | <<symbol>>
          | <<match>>
          | <<let>>
          | <<expr>> <<expr>>
          | <<string>>
          | <<number>>
          | <<fun>>
          | { <<expr>> ; [<<expr>>] }

<<fun>> => fun (<<paramList>>) -> <<expr>> 
<<match>> => match <<expr>> {
    | <<case>> ;
}
<<case>> => <<cons>> [when <<expr>>] -> <<expr>>


