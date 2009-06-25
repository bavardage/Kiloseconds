while true do
  io.write("\rIt is ", (os.date("%H")*3600 + os.date("%M")*60 + os.date("%S"))/1000, " kiloseconds")
  io.stdout:flush()
  os.execute("sleep 0.7")
end

