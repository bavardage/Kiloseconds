program Kiloseconds;

Uses sysutils;

var
    HH, MM, SS, MS : Word;

begin
    DecodeTime(Time, HH, MM, SS, MS);
    writeln(formatfloat('#.###', HH*3.6 + MM*0.06 + SS*0.001 + MS*0.000001), ' kiloseconds');
end.
