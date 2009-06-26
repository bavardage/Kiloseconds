-module(kiloseconds).
-export([kilotime/0]).
kilotime() ->
{Hour,Minutes,Seconds} = erlang:time(),
io:format("It is ~w kiloseconds ~n", [(Hour * 3600 + Minutes * 60 + Seconds)/1000]).
