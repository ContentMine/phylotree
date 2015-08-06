#!/bin/bash
# Usage: attempt to make a plaintext conversion copy of all PDFs in all subfolders (maxdepth 1 folder down) of the working directory

# Turning on the nullglob shell option
shopt -s nullglob

# Loop through pwd cd'ing into each directory then pdftotext all PDFs within each subdirectory
  for f in *.pdf
	do
	echo "started on $f"
	STEM=$(echo $f | sed 's/....$//')
	echo "pdftotext $f"
	pdftotext "$f"
	echo "pdfimages $f"
        pdfimages -j "$f" ${STEM}
	echo "find and delete small files $f"
	find . -maxdepth 1 -type f -size -23k -regex ".*\(ppm\|jpg\|pbm\)$" -exec rm -rf {} \;
	echo "move in $f"
	grep -A2 'Fig\. [0-9]\.' *.txt | sed 's/[^[:alnum:][:punct:][:blank:]]*//g' > captions${STEM}.out
	grep -i -m1 -h '10\.1099\/ijs' *.txt | sed 's/DOI /http:\/\/dx\.doi\.org\//g' > doi_${STEM}.doi
	PARTIAL=$(grep -i -m1 -h '10\.1099\/ijs' *.txt | cut -c 13- | sed 's/\//SLASH/g' | sed 's/^.*10\.1099/10\.1099/g' )
	mkdir $PARTIAL
	#curl -LH "Accept: text/x-bibliography; style=apa" $(cat doi_${STEM%%.*}.doi) > apastring.ref
	#convert ppm's and pbm's to png's & jpg's
	find . -maxdepth 1 -type f -name '*.pbm' | cut -c 3- > needtonegate.zzz
	find . -maxdepth 1 -type f -name '*.ppm' | cut -c 3- > needtoconvert.zzz
	for img in $(cat needtoconvert.zzz) 
		do convert $img $img.png
	done
	for smg in $(cat needtonegate.zzz) 
		do convert $smg -negate $smg.png
	done
	echo "grep captions out $f"
	rm *.ppm
	rm *.pbm
	find . -maxdepth 1 -type f -name '*.txt' -exec mv "{}"  ./$PARTIAL \; 
	find . -maxdepth 1 -type f -name '*.jpg' -exec mv "{}"  ./$PARTIAL \;
	find . -maxdepth 1 -type f -name '*.png' -exec mv "{}"  ./$PARTIAL \;
	find . -maxdepth 1 -type f -name '*.ref' -exec mv "{}"  ./$PARTIAL \;
	find . -maxdepth 1 -type f -name '*.doi' -exec mv "{}"  ./$PARTIAL \;
	find . -maxdepth 1 -type f -name '*.out' -exec mv "{}"  ./$PARTIAL \;
	done
