#!/bin/bash
mkdir -p pdf
if test -f "pdf/output.aux"; then
    rm pdf/*
fi
latexmk -pdf -jobname=pdf/output main.tex -f
count=`ls -1 *.aux 2>/dev/null | wc -l`
if [ $count != 0 ]
then
    mv *.aux pdf/
fi
count=`ls -1 *.bbl 2>/dev/null | wc -l`
if [ $count != 0 ]
then
    mv *.bbl pdf/
fi
count=`ls -1 *.blg 2>/dev/null | wc -l`
if [ $count != 0 ]
then
    mv *.blg pdf/
fi
mkdir -p pdf/log
find pdf -maxdepth 1 -type f -not -name 'output.pdf' -exec mv {} pdf/log/ \;
