#!/bin/bash

infolder='../source/platforms'
outfile='./library.txt'

for file in $(find $infolder -type f -name "*.html.markdown")
do
    platform=`sed 's/title: //;2q;d' $file`
    sed "s/$/ $platform/;s/^- //;1,6d" $file >> $outfile
done