#!/bin/bash
source ./common.sh

checkroot

dnf install mysql-server -y


systemctl restart mysqld
systemctl enable mysqld
systemctl start mysqld



mysql -h db.vjeeth.site -uroot -pExpenseApp@1 -e 'show databases;'
if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ExpenseApp@1
   
else
    echo "already created skipping"
fi

