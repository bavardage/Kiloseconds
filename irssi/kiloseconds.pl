#!/usr/bin/perl

use vars qw($VERSION %IRSSI);
use Irssi;
use strict;
$VERSION = '0.10';
%IRSSI = (
   authors	=> 'Ben Duffield',
   contact	=> 'jebavarde AT gmail DOT com',
   name	=> 'kiloseconds',
   description	=> 'Reports the time in kiloseconds',
   license	=> 'GPL',
   url		=> 'http://wiki.archlinux.org/index.php/Kiloseconds',
   changed	=> 'no idea',
);


sub cmd_kiloseconds {
    my ($data, $server, $witem) = @_;
    my $output;
    my $ks;
    my $s;
    my $m;
    my $h;

    ($s,$m,$h) = localtime();
    $ks = ($h*3600+$m*60+$s)/1000;

    $output = sprintf("Current time: %.3f  kiloseconds", $ks);


    if ($output) {
	if ($witem && ($witem->{type} eq "CHANNEL" || $witem->{type} eq "QUERY")) {
	    $witem->command("MSG ".$witem->{name}." $output");
	}
	else {
	    Irssi::print("This is not a channel/query window :b");
	}
    }
}

Irssi::command_bind('kiloseconds', 'cmd_kiloseconds');

