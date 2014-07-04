#!/bin/perl
#
# Purpose: extracts the filesystem from a downloaded firmware update file (idl4k.bin) to a directory.
# Usage: perl extract_initramfs.perl idl4k.bin
#
use IPC::Open3;
use strict;

$/=undef;

my $inputfile=<>;

if( $inputfile =~ /(\x1f\x8b.*)/s )
{ 
	my $archive	= $1;
	
	printf STDERR "Archive size:%d\n",length($archive);
	my $pid=open3(\*CIN,\*COUT,\*CERR,"gzip -cd") || die"Cant open3\n";

	if(!fork())
	{
		my $byteswritten = syswrite CIN,$archive;
		close(CIN);
		exit(0);
	}
	close(CIN);

	my $uncompressed;
	
	do
	{
		my $read = <COUT>;
		$uncompressed .= $read;
	}
	while( !eof(COUT) && 0==kill(0,$pid) );
	
	printf STDERR "Uncompressed:%d\n",length($uncompressed);
	
	if( $uncompressed =~ /(0707010.*TRAILER!!!\0{4})/s )
	{
		my $cpio = $1;
		printf STDERR "CPIO size:%d\n",length($cpio);
		
		my $extractdirectory = 'initramfs';
		
		if( $cpio =~ m#echo\s*"\s*>>>>\s*AXE PLATFORM\s*:\s*V([\d\.]+)\s*<<<<"#s )
		{
			$extractdirectory .= '.'.$1;
			print STDERR "Found version: $extractdirectory\n";
		}
		
		if( ! -d $extractdirectory )
		{
			mkdir($extractdirectory);
			chdir($extractdirectory);
			open(CPIO,"|cpio -i 2>/dev/null");
			print CPIO $cpio;
			$|=1;
			close(CPIO);
			chdir("..");
			system("chmod","-R","u+rwX",$extractdirectory);
			exit(0);
		}
		else
		{
			print STDERR "Won't extract archive as $extractdirectory directory already exists\n";
		}
	}
	else
	{
		print STDERR "Could not find CPIO in uncompressed data\n";
	}
}
else
{
	print STDERR "Could not find GZIP header in file\n";
}