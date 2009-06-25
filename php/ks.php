<?php
$t = localtime(time(), true);
$ks = $t['tm_hour']*3600 + $t['tm_min']*60 + $t['tm_sec'];
fwrite(STDOUT, "It's " . $ks/1000 . " kiloseconds\n");
?>

