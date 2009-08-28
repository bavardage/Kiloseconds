: seconds time&date 2drop drop 60 * + 60 * + ;
: split-num 10 /mod ?dup if recurse then ;
: print-ks seconds split-num depth 0 ?do 48 + emit depth 3 = if 46 emit then loop ;
." it is now " print-ks ."  kiloseconds " bye
