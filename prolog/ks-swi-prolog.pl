#!/usr/bin/env swipl -g kiloseconds -s
kiloseconds :-
    get_time(T),
    stamp_date_time(T,date(_,_,_,H,M,S,_,_,_),'local'),
    format('It is: ~f kiloseconds.~n',[(H*3600+M*60+S)/1000]).
