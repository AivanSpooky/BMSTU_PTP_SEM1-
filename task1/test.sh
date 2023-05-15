#!/bin/bash

# Тестирование скрипта comparator1.sh
chmod +x comparator1.sh

# Тесты (1-3) - Проверка на несуществующие файлы
echo "Тесты (1-3) - Проверка на несуществующие файлы"
./comparator1.sh not_exist.txt not_exist.txt
./comparator1.sh not_exist.txt tests/1.txt
./comparator1.sh tests/1.txt not_exist.txt

# Тесты (4-6) - Проверка одинаковых файлов
echo "Тесты (4-6) - Проверка одинаковых файлов"
./comparator1.sh tests/1.txt tests/1.txt
./comparator1.sh tests/1.txt tests/2.txt
./comparator1.sh tests/2.txt tests/1.txt

# Тесты (7-10) - Проверка файлов без чисел
echo "Тесты (7-10) - Проверка файлов без чисел"
./comparator1.sh tests/1.txt tests/3.txt
./comparator1.sh tests/3.txt tests/1.txt
./comparator1.sh tests/3.txt tests/3.txt
./comparator1.sh tests/3.txt tests/5.txt

# Тесты (11-12) - Проверка пустых файлов
echo "Тесты (11-12) - Проверка пустых файлов"
./comparator1.sh tests/4.txt tests/4.txt
./comparator1.sh tests/1.txt tests/4.txt

# Тесты (13-15) - Проверка файлов с одинаковым количеством чисел
echo "Тесты (13-15) - Проверка файлов с одинаковым количеством чисел"
./comparator1.sh tests/6.txt tests/7.txt
./comparator1.sh tests/7.txt tests/8.txt
./comparator1.sh tests/6.txt tests/8.txt

# Тесты (16-17) - Проверка файлов с числами внутри слов (без отделения пробельными символами)
echo "Тесты (16-17) - Проверка файлов с числами внутри слов (без отделения пробельными символами)"
./comparator1.sh tests/6.txt tests/9.txt
./comparator1.sh tests/9.txt tests/10.txt

# Тесты (18) - Проверка файлов с числами 2 и 02
echo "Тесты (18) - Проверка файлов с числами 2 и 02"
./comparator1.sh tests/6.txt tests/11.txt