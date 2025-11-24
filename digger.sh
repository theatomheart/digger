#!/bin/sh

RecordTypes="any ns a mx srv txt x"

Domains="$HOME/domains.txt"	# This is your file with a list of domain names.

Outpath="$HOME/.digger"		# This is the path the output will be saved to.

if [ ! -f $Domains ] ; then echo "The file $Domains is missing." && exit 1 ; fi

DigLines=$(cat $Domains)

for Line in $DigLines
do
	mkdir -p "$Outpath/$Line"
	Output="$Outpath/$Line/$(date +%Y_%b_%d).md"
	echo "# Dig report for $Line" >> $Output
	for Type in $RecordTypes
	do
		echo "" >> $Output ; echo "## Record type: $Type" >> $Output
		dig $Type $Line +noall +answer >> "$Output"
	done
done
