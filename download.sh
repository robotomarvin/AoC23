#!/bin/bash

DAY=$1
mkdir "d$1"
cd "d$1"

curl --cookie "session=$AOC_SESSION" https://adventofcode.com/2023/day/$1/input > input.txt
curl --cookie "session=$AOC_SESSION" https://adventofcode.com/2023/day/$1 > instructions.html
cat instructions.html | xq -x '//pre/code' > test
cat instructions.html | xq -x '//article' > instructions
rm instructions.html 

touch run.rb
