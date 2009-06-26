program Kiloseconds;

{$APPTYPE CONSOLE}

uses
SysUtils;

var
h,m,s,ms: word;
begin
DecodeTime(now, h, m, s, ms);
Writeln('It is ' + FloatToStrF( (h*3600 + m*60 + s) / 1000, ffNumber, 7, 2) + ' kiloseconds.');
end.
