select ((to_char(sysdate,'HH')*60*60)+(to_char(sysdate,'MM')*60)+(to_char(sysdate,'SS')))/1000 
as "Kiloseconds" from dual
