select (extract(hour from localtime)*3600 + extract(minute from localtime)*60 + extract(second from 
                   localtime))/1000;
