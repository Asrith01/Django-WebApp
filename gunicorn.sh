#!/bin/bash

cd /var/lib/jenkins/workspace/django

$PWD

source rahul/bin/activate
pip install django
pip install gunicorn

python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py collectstatic 

echo "Migrations done"


sudo rm /etc/systemd/system/gunicorn.service
sudo cp -rf gunicorn.socket /etc/systemd/system/
sudo cp -rf gunicorn.service /etc/systemd/system/

echo "$USER"
echo "$PWD"



sudo systemctl daemon-reload
sudo systemctl start gunicorn

echo "Gunicorn has started."

sudo systemctl enable gunicorn

echo "Gunicorn has been enabled."

sudo systemctl restart gunicorn


sudo systemctl status gunicorn
