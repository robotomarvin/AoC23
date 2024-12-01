#!/bin/bash
cd "$(dirname "$0")"

DAY=$(date +%d | sed 's/^0*//')
DAY_PREFIXED=$(date +%d)
YEAR=$(date +%Y)
mkdir -p "$YEAR/d$DAY_PREFIXED"
cd "$YEAR/d$DAY_PREFIXED"

curl --cookie "session=$AOC_SESSION" https://adventofcode.com/$YEAR/day/$DAY/input > input.txt
curl --cookie "session=$AOC_SESSION" https://adventofcode.com/$YEAR/day/$DAY > instructions.html
cat instructions.html | xq -x '//pre/code' > test
cat instructions.html | xq -x '//article' > instructions
rm instructions.html 

FILE="run.rb"
if [ ! -f $FILE ]; then
  cp ../../template.rb $FILE
fi
