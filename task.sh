#!/bin/bash

summ=0
got_number=0

while True; do
    read $a
    if [[ $a =~ ^["STOP"]$ ]]; then
        break
    elif [[ $a =~ ^[+-]?[0-9]+([.][0-9]+)?$ ]]; then
        got_number=1
        summ=$(($summ + $a))
    fi
done

echo $summ
if [[ $got_number == 0 ]]; then
    exit 100
else
    exit 0
fi