#!/bin/bash

# Тестирование скрипта comparator2.sh
chmod +x comparator2.sh

# Тесты (1-3) - Проверка на несуществующие файлы
echo "Тесты (1-3) - Проверка на несуществующие файлы"
./comparator2.sh not_exist.txt not_exist.txt
./comparator2.sh not_exist.txt tests/1.txt
./comparator2.sh tests/1.txt not_exist.txt

# Тесты (4-6) - Проверка одинаковых файлов
echo "Тесты (4-6) - Проверка одинаковых файлов"
./comparator2.sh tests/2.txt tests/2.txt it
./comparator2.sh tests/2.txt tests/7.txt it
./comparator2.sh tests/7.txt tests/2.txt it

# Тесты (7-10) - Проверка пустого файла и со строками (+ если подстроки нет хотя бы в одном файле)
echo "Тесты (7-10) - Проверка пустого файла и со строками (+ если подстроки нет хотя бы в одном файле)"
./comparator2.sh tests/1.txt tests/3.txt it
./comparator2.sh tests/3.txt tests/1.txt it
./comparator2.sh tests/1.txt tests/3.txt popit
./comparator2.sh tests/2.txt tests/4.txt someint

# Тесты (11-12) - Проверка файлов на неодинаковые строки после первого вхождения подстроки
echo "Тесты (11-12) - Проверка файлов на неодинаковые строки после первого вхождения подстроки"
./comparator2.sh tests/2.txt tests/6.txt lmao
./comparator2.sh tests/8.txt tests/9.txt i

# Тесты (13-15) - Проверка файлов на различие в количестве пробельных символов
echo "Тесты (13-15) - Проверка файлов на различие в количестве пробельных символов"
./comparator2.sh tests/3.txt tests/4.txt it
./comparator2.sh tests/3.txt tests/5.txt it
./comparator2.sh tests/9.txt tests/10.txt too