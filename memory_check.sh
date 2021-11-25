#!/bin/bash
function memorycheck () {
    memusage=$(free | awk '/Mem/{printf("RAM Usage: %.2f%\n"), $3/$2*100}' |  awk '{print $3}' | cut -d"." -f1)}


while getopts ":cwe:" opt; do
   case $opt in
       c) input = "$percentage";;
       w) input = "$percentage";;
       e) input = "$email";;
       \?) help; exit;;
   esac
      done
      
      if ["$input" = "" ]
      then 
        echo "Please provide the following parameters: \n[c] Critical Threshold (percentage)
            \n[w] Warning Threshold (percentage)
            \n[e] email address to send the report;"
            exit
        fi