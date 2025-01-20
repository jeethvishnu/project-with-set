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

val(){
    if [ $1 -ne 0 ]
    then
        echo "failed"
        exit 1
    else
        echo "success"
    fi
}

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
