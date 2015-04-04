#!/bin/bash
# to get the character count of a sentence
# run : bash~# sh s-word-count.sh github.com
data=$1
count=$(echo $data | wc -c)
echo "The given string character coutn is - $data -" $count
