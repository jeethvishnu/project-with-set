#!/bin/bash
source ./common.sh

checkroot

dnf install nginx -y 
val $? "installing"
systemctl enable nginx
val $? "enbaling"

systemctl start nginx
val  $? "starting"

rm -rf /usr/share/nginx/html/*

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip

val $? "removing and downloading"

cd /usr/share/nginx/html

unzip /tmp/frontend.zip

cp /home/ec2-user/project-with-set/fd.conf /etc/nginx/default.d/expense.conf
val $? "copied expense conf"

systemctl restart nginx
val $? "restart"
