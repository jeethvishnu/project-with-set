#!/bin/bash

usr=$(id -u)
timestamp=$(date +%F-%H-%M-%S)
script=$(echo $0 | cut -d "." -f1)
log=/tmp/$script-$timestamp.log

if [ usr -ne 0 ]
then
    echo "is this sudo"
    exit 1
else    
    echo "SUDO"

fi

val(){
    if [ $1 -ne 0 ]
    then
        echo "failed"
    else
        echo "success"
    fi
}

dnf install mysql-server -y
val $? "installing"

systemctl restart backend
systemctl enable backend
systemctl start backend

val $? "enabling and starting"

mysql -h db.vjeeth.site -uroot -pExpenseApp@1 -e 'show databases;'
if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ExpenseApp@1
    val $? "passwd creation"
else
    echo "already created skipping"
fi

