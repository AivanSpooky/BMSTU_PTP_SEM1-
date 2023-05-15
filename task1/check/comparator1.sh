#!/bin/bash

# Функция для проверки слова на то, что это число
function is_digit
{
	if [[ $1 =~ ^[+-]?[0-9]+$ ]]; then
		echo 1
	else
		echo 0
	fi
}

file1=$1
file2=$2
output=$3

# проверяем существует ли первый файл
if ! [ -f "$file1" ]; then
	if [ "$output" == "-v" ]; then
		echo "File 1 doesn't exist"
	fi
	exit 2
fi

# проверяем существует ли второй файл
if ! [ -f "$file2" ]; then
	if [ "$output" == "-v" ]; then
		echo "File 2 doesn't exist"
	fi
	exit 2
fi
file1_num=0
file2_num=0
file1_num_cnt=0
file2_num_cnt=0

# Сравнивание чисел из обоих файлов
for word1 in $(cat $file1); do
	if [[ "$( is_digit "$word1" )" -eq 1 ]]; then
		file1_num=$((file1_num + 1))
		file1_num_cnt=$((file1_num_cnt + 1))
		file2_num=0
		file2_num_cnt=0
		for word2 in $(cat $file2); do
			if [[ "$( is_digit "$word2" )" -eq 1 ]]; then
				file2_num_cnt=$((file2_num_cnt + 1))
				file2_num=$((file2_num + 1))
				if [[ file2_num -eq file1_num ]]; then
					if [[ word1 -ne word2 ]] || [[ ${#word1} != ${#word2} ]]; then
						echo "Files are not equal"
						exit 1
					fi
				fi
			fi
		done
	fi
done

# Проверка второго файла на наличие чисел
if [ $file1_num_cnt -eq 0 ] && [ $file2_num_cnt -eq 0 ]; then
	for word2 in $(cat $file2); do
		if [[ "$( is_digit "$word2" )" -eq 1 ]]; then
			file2_num_cnt=$((file2_num_cnt + 1))
		fi
	done
fi

if [[ file1_num_cnt -ne file2_num_cnt ]]; then
	echo "Files are not equal"
	exit 1
else
	echo "Files are equal"
	exit 0
fi
