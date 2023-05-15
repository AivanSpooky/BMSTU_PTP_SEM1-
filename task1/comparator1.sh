#!/bin/bash

# Функция для проверки на число
function num
{
	if [[ $1 =~ ^[+-]?[0-9]+$ ]]; then
		echo 1
	else
		echo 0
	fi
}

f1=$1
f2=$2
if [ ! -f $f1 ]; then
    echo "$f1 (файл не существует)."
	exit 1
elif [ ! -f $f2 ]; then
	echo "$f2 (файл не существует)."
	exit 1	
fi
f1_num=0
f2_num=0
f1_num_count=0
f2_num_count=0

# Сравнивание чисел из обоих файлов
for word1 in $(cat $f1); do
	if [[ "$( num $word1 )" -eq 1 ]]; then
		f1_num=$(($f1_num + 1))
		f1_num_count=$(($f1_num_count + 1))
		f2_num=0
		f2_num_count=0
		for word2 in $(cat $f2); do
			if [[ "$( num $word2 )" -eq 1 ]]; then
				f2_num_count=$(($f2_num_count + 1))
				f2_num=$(($f2_num + 1))
				if [[ f2_num -eq f1_num ]]; then
					if [[ word1 -ne word2 ]] || [[ ${#word1} != ${#word2} ]]; then
						echo "Файлы не совпадают."
						exit 1
					fi
				fi
			fi
		done
	fi
done

# Проверка второго файла на наличие чисел
if [ $f1_num_count == 0 -a $f2_num_count == 0 ]; then
	for word2 in $(cat $f2); do
		if [[ "$( num $word2 )" -eq 1 ]]; then
			f2_num_count=$(($f2_num_count + 1))
		fi
	done
fi

if [[ f1_num_count -ne f2_num_count ]]; then
	echo "Файлы не совпадают."
	exit 1
else
	echo "Файлы совпадают."
	exit 0
fi
