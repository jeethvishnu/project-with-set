#!/bin/bash
source ./common.sh


dnf module list nodejs -y
dnf disable nodejs:18 -y
dnf enable nodejs:20 -y
dnf install nodejs -y
val $? "enabling and installing"

id expense
if [ $? -ne 0 ]
then
    useradd expense
    val $? "useradded"
else
    echo "already added skipping"
fi

mkdir -p /app

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip
val $? "dir created and zip installed"

cd /app
rm -rf /app/*
unzip /tmp/backend.zip

val $? "unzipping"

npm install

cp /home/ec2-user/project-with-set/bk.service /etc/systemd/system/backend.service
val $? "copying"

systemctl daemon-reload

systemctl start backend

systemctl enable backend
val $? "enabling and starting"

dnf install mysql -y
val $? "installing"

mysql -h db.vjeeth.site -uroot -pExpenseApp@1 < /app/schema/backend.sql


systemctl restart backend
val $? "restarting"
