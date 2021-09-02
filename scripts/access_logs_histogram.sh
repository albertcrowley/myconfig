#!/bin/bash

file=/var/log/httpd/access_log

if [ $# -eq 0 ]
  then
    d=`date +%d.%b`
    echo "checking"
  else 
      d=$1
      if [ $# -eq 1 ]
      then
	  file=/var/log/httpd/access_log
      else
	  file=$2
      fi
fi


echo "will filter by arg1 regex if given, today's date otherwise"
echo "Ex. access_logs_histogram.sh '07.Oct'"
echo
echo "filtering $file by $d"
echo 



sudo cat $file | awk '{print $4, $9}'  | grep $d | grep -Pho '\d\d:\d\d:\d\d ' | grep -Pho '^\d\d:\d\d' | sort  | uniq -c | tee /tmp/pre-plot.txt | awk '{print NR, $1}' > /tmp/plot.txt

echo "Plot data:"
echo "----------"
cat /tmp/pre-plot.txt

echo "Top 20 IP addresses:"
echo "--------------------"
sudo cat $file | grep $d | awk '{print $1}' | sort | uniq -c | sort -rn | head -20

gnuplot -e "set terminal dumb 1000 49;  set xtics nomirror out; set ytics nomirror out; set border 3; set yrange [0:] ;set nokey ;plot '/tmp/plot.txt' with lines " | less -S
