# phylotree

`ami-phylo` analyses images and diagrams to extract phylogenetic trees. This is a complete repository of the analysis of ca 4500 files from IJSEM, carried out as Open Notebook Science. The intention is that everything in the analysis is either accessible here or should be Open and linked from here.

Main headings are:

## description of the workflow

* Scrape figure image content from IJSEM journal website (note: was originall performed on older Highwire platform, not new Ingenta platform)
* Manually filter out non-phylogeny containing figures using [Shotwell](https://wiki.gnome.org/Apps/Shotwell). 
* Pass each of these figures to our software for analysis with this bash while loop:
```
while read i ; do timeout 60s mvn exec:java  -Dexec.mainClass='org.xmlcml.ami2.plugins.phylotree.RunPhylo'  -Dexec.args=''"$i"' ./all-output/'"$i"'' -e -X | tee $i.log ; done <list-of-input-images.txt
```
* check results for OCR errors and Newick structure errors
* Standardise taxa across different studies
* Feed cleaned Newick data to [Supertree Toolkit 2](http://bdj.pensoft.net/articles.php?id=1053) to create a supertree matrix
* Analyse supertree matrix with [TNT](http://www.cladistics.com/aboutTNT.html)

## specification of files, errors, protocols

Figure images were obtained from IJSEM articles from 2003 to 2014 (inclusive).
This includes 4705 articles. 4341 figures containing a dendrogram were extracted from this set of articles.

## input and output files (large)

## errors 


