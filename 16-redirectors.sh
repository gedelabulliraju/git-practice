#!/bin/bash

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER


USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
CHECK_ROOT(){
    if [ $USERID -ne 0 ]
then
    echo -e "$R Please run this script with root priveleges $N" | tee -a $LOG_FILE
    exit 1
fi
}
VALIDATE()
{
    if [ $1 -ne 0 ]
    then
    echo -e "$2 is $R failure $N" 
    exit 1
    else
    echo -e "$2 is $G success $N" 
    fi
}


CHECK_ROOT
for package in $@ #sudo sh 15-loops.sh git mysql postfix nginx
do

dnf list installed $package | tee -a $LOG_FILE # Just checking whether installed or not

if [ $? -ne 0 ]
then
    echo "$package is not installed, going to install it.." | tee -a $LOG_FILE
    dnf install $package -y | tee -a $LOG_FILE
   VALIDATE $? "Installing $package" | tee -a $LOG_FILE
else
    echo -e "$G $package is already installed $N, nothing to do.." | tee -a $LOG_FILE
fi
done