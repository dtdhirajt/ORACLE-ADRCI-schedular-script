#!/bin/bash 

## While executing this script you have to pass two parameter, ORACLE_HOME path and RETENTION_DAYS for no of days you
## you want to store diagnostic data.

ORACLE_HOME=$1 
RETENTION_DAYS=$2 
RETENTION_HOURS=$(($RETENTION_DAYS * 24)) 
PATH=$PATH:$ORACLE_HOME/bin 

## This Will pick all diagnsotic home one by one and set SHORTP_POLICY and LONGP_POCILY to RETENTION_HOURS
## and then purge diagnostic data


adrci exec="show homes"|grep -v : | while read file_line 
do 
if [[ $file_line == *"$i"* ]] ; then 
adrci exec="set homepath $file_line;set control \(SHORTP_POLICY=${RETENTION_HOURS}\);" 
adrci exec="set homepath $file_line;set control \(LONGP_POLICY=${RETENTION_HOURS}\);" 
adrci exec="set homepath $file_line;purge;" 
fi 
done 
