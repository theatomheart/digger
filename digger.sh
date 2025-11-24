#!/bin/sh

Domains="$HOME/domains.txt"	# This is your file with a list of domain names.

Outpath="$HOME/.digger"		# This is the path the output will be saved to.

RecordTypes="any ns a mx srv txt x"

Output="$(date +%Y_%b_%d).md"

if [ ! -f $Domains ] ; then echo "The file $Domains is missing." && exit 1 ; fi

DigLines=$(cat $Domains)

for Line in $DigLines
do
	echo "# Dig report for $Line" >> $Output
	for Type in $RecordTypes
	do
		mkdir -p "$Outpath/$Line"
		cd "$Outpath/$Line"
		echo "### Record type: $Type" >> $Output
		dig $Type $Line +noall +answer >> "$Output"
#		echo "=== End of record type: $Type ===" >> $Output
	done
done
