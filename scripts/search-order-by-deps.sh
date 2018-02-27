#!/bin/bash

SEARCH_STR=$1

xbps-query -Rs $SEARCH_STR | while read line; do
  cand=`echo $line | cut -d' ' -f2  | rev | cut -d'-' -f2- | rev`
  lines=`xbps-install -n $cand | wc -l`
  echo "$lines $line"; 
done | sort -n
