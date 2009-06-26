puts "It's [expr [clock format [clock seconds] -format {(%k*3600+%M.0*60+%S.0)/1000}]] kiloseconds"
