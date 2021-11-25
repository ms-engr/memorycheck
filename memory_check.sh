#!/bin/bash
trap "exit 1" term
export TOP_PID=$$

function memorycheck(){
    memusage=$(free | awk '/Mem/{printf("RAM Usage: %.2f%\n"), $3/$2*100}' |  awk '{print $3}' | cut -d"." -f1)
    echo "Memory usage is $memusage%"
     }
    
function parameter(){ while getopts ":cwe:" opt; do
   case $opt in
       c) input1="$cpercentage";;
       w) input2="$wpercentage";;
       e) input3="$email";;
       \?) help;exit 1;;
   esac
 done
 
 
      if [ "$input1" = "" ]
      then 
      echo "Please indicate critical threshold"
      elif [ "$input2" = "" ]
      then 
      echo "Please warning critical threshold"
       elif [ "$input3" = "" ]
      then 
      echo "Please enter email"
      else 
      verify
        fi
}

function verify(){
    if  [ "$input1" -gt "$input2"  ]
    then  
      check
    else 
      parameter
    fi
}

        
function help(){
    echo "Please provide the following parameters"
    parameter
}

function check(){
    if [ "$memusage" -ge "$input1" ]
    then 
    SUBJECT=" `date '+%Y%m%d %H:%M'` memory check - critical "
    MESSAGE="/tmp/Mail.out"
    TO="monica.mamitag@gmail.com"
  echo "Current memory is: $memusage%" >> $MESSAGE
  echo "" >> $MESSAGE
  echo "+------------------------------------------------------------------+" >> $MESSAGE
  echo "Top 10 processes consuming high memory:" >> $MESSAGE
  echo "+------------------------------------------------------------------+" >> $MESSAGE
  echo "$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -10)" >> $MESSAGE
  mail -s "$SUBJECT" "$TO" < $MESSAGE
  rm /tmp/Mail.out
    elif [ "$memusage" -ge "$input2" ]
    then
     kill -s TERM $TOP_PID
    elif ["$memusage" -lt "$input2"]
    then
    kill -s TERM $TOP_PID
    fi
}     

memorycheck
parameter

