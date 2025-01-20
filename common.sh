#!/bin/bash

usr=$(id -u)
timestamp=$(date +%F-%H-%M-%S)
script=$(echo $0 | cut -d "." -f1)
log=/tmp/$script-$timestamp.log

if [ $usr -ne 0 ]
then
    echo "is this sudo"
    exit 1
else    
    echo "SUDO"

fi

checkroot(){

    if [ $1 -ne 0 ]
    then
        echo "failed"
        exit 1
    else
        echo "success"
    fi
}