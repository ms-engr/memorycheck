#!/bin/bash

function memorycheck(){
    memusage=$(free | awk '/Mem/{printf("RAM Usage: %.2f%\n"), $3/$2*100}' |  awk '{print $3}' | cut -d"." -f1)
    echo "Memory usage is $memusage%"
     }
     
     
function check(){
    
}     
function verify(){
    if  [ "$input1" -gt "$input2"  ]
    then  
      check
    else 
      memorycheck
    fi
}

        
function help(){
    echo "Please provide the following parameters"
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

memorycheck
parameter

