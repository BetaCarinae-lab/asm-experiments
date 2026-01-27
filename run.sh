#!/usr/bin/env bash

nasm -f elf64 ./code/$1 -o ./bin/$2
ld ./bin/$2 -o ./bin/out
./bin/out
