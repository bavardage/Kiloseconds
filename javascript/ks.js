ourDate = new Date();
metricTime =  (ourDate.getHours() * 3600 + ourDate.getMinutes() * 60 + ourDate.getSeconds());
document.write("It is: " + metricTime / 1000 + " kiloseconds.");
