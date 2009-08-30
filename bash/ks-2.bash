# date is only invoked once. This variant also outputs the fractional part.
eval $(echo $(($(date +"%-H*3600+%-M*60+%-S")))|sed "s/.*/echo It is \$((&\/1000)).\$((&%1000)) kiloseconds./")

