#! /bin/bash
set -e -x

cp broadsheet/templates/*.css issues/

today=$(date +%Y-%m-%d)
yesterday=$(find issues/ -mtime +1 -type f | tail -n 1 | grep -o "[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}" || true)

if [[ -n "$yesterday" ]]; then
yesterday_arg="-p ${yesterday}"
#yesterday_mtime=$(stat -f "%Sm" -n issues/$yesterday.html)
yesterday_mtime="$(date -d "$(stat -c %y issues/$yesterday.html)" +%FT%T)"
mtime_arg="-s ${yesterday_mtime}"
fi


python broadsheet/crawler.py subscriptions.yaml -o issues/$today.html $yesterday_arg $mtime_arg
#python broadsheet/crawler.py subscriptions.yaml -o issues/$today.html -s "$yesterday_mtime" -p "$yesterday"

cd issues
ln -sf $today.html index.html
cd -
