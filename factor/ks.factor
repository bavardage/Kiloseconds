USING: accessors calendar kernel math prettyprint ;
IN: kiloseconds

: kiloseconds ( -- n )
    now [ hour>> 3600 * ] [ minute>> 60 * ]
    [ second>> ] tri + + 1000 /i ;

: main ( -- )
    kiloseconds . ;

MAIN: main
