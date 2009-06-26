function ks = kiloseconds();
% make a clock
c = clock;
% get hour
hour = c(4);
% get minutes 
min = c(5);
% get seconds
sec = c(6);
ks = (hour * (min*60) * sec)/ 1000;
