\ Forth example without floating point division (but instead a special printing function).
\ Tested with gforth 64 bit.

: dk. s>d <# # # # '. hold #s #> type ;
: seconds ( -- n ) time&date 2drop drop 60 * + 60 * + ;
: printkstime ( -- ) ." It is " seconds dk. ." kiloseconds." cr ;

printkstime
bye

