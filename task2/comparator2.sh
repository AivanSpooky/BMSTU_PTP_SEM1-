#!/bin/bash

lines_found=0
f1=$1
f2=$2
if [ ! -f $f1 ]; then
    echo "$f1 (файл не существует)."
	exit 1
elif [ ! -f $f2 ]; then
	echo "$f2 (файл не существует)."
	exit 1	
fi
string=$3
l1_num=0
l2_num=0
r=0
while read word1; do
    l1_num=$(($l1_num+1))
    if [[ $word1 =~ .*$string.* ]] || [ $lines_found == 1 ]; then
        l2_num=0
        while read word2; do
            l2_num=$(($l2_num+1))
            if [[ $word2 =~ .*$string.* ]]  &&  [ $lines_found == 0 ]; then
                r=$l1_num-$l2_num
                lines_found=1
                sent1_end=$(echo "$word1" | sed  "s/.*${string}/""/")
                sent2_end=$(echo "$word2" | sed  "s/.*${string}/""/")
                if [[ ! $sent1_end == $sent2_end ]]; then
                    echo "Файлы не совпадают"
                    exit 1
                fi
            elif [ $lines_found == 1 ] && [[ $(($l1_num - $l2_num)) -eq $r ]]; then
                if [[ ! $word1 == $word2 ]]; then
                    echo "Файлы не совпадают"
                    exit 1
                fi
            elif [[ $(($l1_num - $l2_num)) -lt $r ]]; then
                break
            fi
        done < $f2
        if [[ $l2_num == 0 ]]; then
            echo "Файлы не совпадают"
            exit 1
        fi
    fi
done < $f1

if [[ $l1_num == 0 ]]; then
    while read word2; do
        if [[ $word2 =~ .*$string.* ]]; then
            echo "Файлы не совпадают"
            exit 1
        fi
    done < $f2
fi
echo "Файлы совпадают"
exit 0