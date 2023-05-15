#!/bin/bash

# Функция для сравнения строк после первого вхождения слова
function compare_sent
{
    ss="$3"
    sent1_end=$(echo "$1" | sed  "s/.*${ss}/""/")
    sent2_end=$(echo "$2" | sed  "s/.*${ss}/""/")
    if [[ $sent1_end == $sent2_end ]]; then
        echo 1
    else
        echo 0
    fi
}


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
for word1 in $(cat $f1); do
    l1_num=$(($l1_num+1))
    if [[ $word1 =~ .*$string.* ]] || [ $lines_found == 1 ]; then
        l2_num=0
        for word2 in $(cat $f2); do
            l2_num=$(($l2_num+1))
            if [[ $word2 =~ .*$string.* ]]  &&  [ $lines_found == 0 ]; then
                r=$l1_num-$l2_num
                lines_found=1
                if [[ $(compare_sent $word1 $word2 $string) -eq 0 ]]; then
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
        done
        if [[ $l2_num == 0 ]]; then
            echo "Файлы не совпадают"
            exit 1
        fi
    fi
done < $f1

if [[ $l1_num == 0 ]]; then
    for word2 in $(cat $f2); do
        if [[ $word2 =~ .*$string.* ]]; then
            echo "Файлы не совпадают"
            exit 1
        fi
    done
fi
echo "Файлы совпадают"
exit 0