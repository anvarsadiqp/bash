#!/bin/bash
data=$1
count=$(echo $data | wc -c)

echo "The string count- $data -" $count
