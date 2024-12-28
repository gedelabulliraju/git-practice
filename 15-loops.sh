#!/bin/bash

USERID=$(id -u)
#echo "User ID is: $USERID"
R="\e[31m"
G="\e[32m"
N="\e[0m"
CHECK_ROOT(){
    if [ $USERID -ne 0 ]
then
    echo "Please run this script with root priveleges"
    exit 1
fi
}
VALIDATE()
{
    if [ $1 -ne 0 ]
    then
    echo -e "$2 is $R failure $N"
    else
    echo -e "$2 is $G success $N"
    exit 1
    fi
}


CHECK_ROOT
for package in $@ #sudo sh 15-loops.sh git mysql postfix nginx
do

dnf list installed $package # Just checking whether installed or not

if [ $? -ne 0 ]
then
    echo "$package is not installed, going to install it.."
    dnf install git -y # here installing
   VALIDATE $? "Installing $package"
else
    echo -e "$G $package is already installed $N, nothing to do.."
fi
done