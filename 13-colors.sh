#!/bin/bash

USERID=$(id -u)
#echo "User ID is: $USERID"
R="\e[31m"
G="\e[32m"
N="\e[0m"
VALIDATE()
{
    if [ $? -ne 0 ]
    then
    echo -e "command is $R failure $N"
    else
    echo -e "command is $G success $N"
    exit 1
    fi
}


if [ $USERID -ne 0 ]
then
    echo "Please run this script with root priveleges"
    exit 1
fi

dnf list installed git # Just checking whether installed or not

if [ $? -ne 0 ]
then
    echo "Git is not installed, going to install it.."
    dnf install git -y # here installing
   VALIDATE $? "Installing Git"
else
    echo -e "$G Git is already installed $N, nothing to do.."
fi

dnf list installed mysql 

if [ $? -ne 0 ]
then
    echo "MySQL is not installed...going to install"
    dnf install mysql -y
    VALIDATE $? "Installing sql"
else
    echo -e "$G MySQL is already installed$N..nothing to do"
fi