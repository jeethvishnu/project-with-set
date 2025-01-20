#!/bin/bash
source ./common.sh

checkroot

dnf install nginx -y 

systemctl enable nginx


systemctl start nginx


rm -rf /usr/share/nginx/html/*

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip



cd /usr/share/nginx/html

unzip /tmp/frontend.zip

cp /home/ec2-user/project-with-set/fd.conf /etc/nginx/default.d/expense.conf


systemctl restart nginx

