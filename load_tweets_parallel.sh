#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
echo "$files" | time parallel ./load_denormalized.sh

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
echo "$files" | time parallel python3 -u load_tweets.py --db=postgresql://postgres:pass@localhost:51382/ --inputs

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
echo "$files" | time parallel python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:51383/ --inputs
