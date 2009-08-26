\ Forth example without floating point division (but instead a special printing function).
\ Tested with gforth 64 bit.

: dk. ( n -- ) s>d swap over dabs <<# # # # [char] . hold #s rot sign #> TYPE SPACE #>> ;
: seconds ( -- n ) time&date 2drop drop 60 * + 60 * + ;
: printkstime ( -- ) ." It is " seconds dk. ." kiloseconds." cr ;

printkstime
bye

