\ Forth example with floating point division.
\ Tested with gforth 64bit.

: kiloseconds ( -- r ) time&date 2drop drop 60 * + 60 * + s>f 1e+3 f/ ;
: printkstime ( -- ) ." It is " kiloseconds f. ." kiloseconds." cr ;

printkstime
bye

