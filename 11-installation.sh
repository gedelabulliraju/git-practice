#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "Please run this script with root preveleses"
    exit 1
fi

dnf list installed git # cheacking install or not
if [ $? -ne 0 ]
    then
    echo "git is not installed going to install"
    dnf install git -y

    else 
    echo "Git is allready installed"
    
fi
dnf list installed mysql # cheacking install or not
if [ $? -ne 0 ]
    then
    echo "mysql is not installed going to install"
    dnf install mysql -y

    else 
    echo "mysql is allready installed"
    exit 1
fi