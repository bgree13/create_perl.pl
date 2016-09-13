#!/usr/bin/perl

use strict;
use warnings;

my $editor = $ENV{EDITOR} || 'vim';
my $perl_version = `/usr/bin/which perl`;

#print "Perl Version: $^V\n";	
#print "Perl Location: $perl_version";	

sub help {
	print "Usage: $0 [file_name.pl]  \n";
}

my $filename = shift or die "Usage: $0 [file_name.pl] \n"; 

sub tuchfl {
	print "Creating new file $filename...\n";
	system(`/usr/bin/touch ./$filename`) || die "Coudln't create file";
}

sub chgmod {
	print "Setting ownership to $filename...\n";
	system(`/bin/chmod +x ./$filename`) || die "Couldn't set ownership";
}
sub wrfile {
	print "Preparing file for writing... \n";

	open(my $fh, ">", $filename) || die "Couldn't open '".$filename."' for reading because: ".$!;
	print $fh "#!$perl_version \n";
	print $fh "use strict;\n";
	print $fh "use warnings;\n";
	print $fh "\n";
	close $fh;
}

sub editfl {
	print "Opening file using $editor editor...\n";
	my $editor = $ENV{EDITOR} || 'vim';
	system $editor => $filename || die "Coudn't edit file using $editor";
}

sub chckfl {
	print "Determining whether file exists...\n";
	#print "File exists" unless;
}

if (-e "$filename"){
	die "Filename => $filename already exists \n";
}
elsif($filename =~ /[a-zA-Z0-9]\.pl/){
	tuchfl();
	chgmod();
	wrfile();
	editfl();
}
else {
	print "Filename must have .pl extension included \n";		
	#help();
}

#print "$filename\n";
