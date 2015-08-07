#!/bin/sh

for i in *.nwk ; do 
		echo processing $i
		java -jar TreeGraph.jar -convert $i -xtg $i.xtg
	    	java -jar TreeGraph.jar -image $i.xtg $i.svg -phyl
		java -jar TreeGraph.jar -image $i.xtg $i.png
	done
