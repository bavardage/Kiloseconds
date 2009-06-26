#!/usr/bin/perl -w
#kilosecondtime.pl
#
use warnings;

use vars qw($VERSION %IRSSI $kstime);

use Irssi;
$VERSION = '0.1';
%IRSSI = (
    authors	=> 'muiro',
    contact	=> 'muiro AT muiro DOT net',
    name 	=> 'kiloseconds-timestamp',
    description => 'This script updates ' .
    	 	   'a kilosecond time variable' .
		   'to replace the basic timestamp.',
    license	=> 'Public Domain',
    url		=> 'http://wiki.archlinux.org/index.php/Kiloseconds',
);

my $kstime;
my $old_timestamp_format = Irssi::settings_get_str('timestamp_format');

sub kser
{
    my ($window, $fg, $bg, $flags, $text, $rec) = @_;
    my $s;
    my $m;
    my $h;

    ($s,$m,$h) = localtime();
    $kstime = sprintf("%.3f",(($h*3600+$m*60+$s)/1000));
    Irssi::command("^set timestamp_format $kstime");
}

sub script_unload
{
	my ($script,$server,$witem) = @_;
	Irssi::command("^set timestamp_format $old_timestamp_format");
}

Irssi::timeout_add(1000,'kser',undef);
Irssi::signal_add_first('command script unload', 'script_unload');
print "kilosecond-timestamp $VERSION loaded";

