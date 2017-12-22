#!/bin/sh
cp deepquote /etc/nginx/sites-available/deepquote
ln -s /etc/nginx/sites-available/deepquote /etc/nginx/sites-enabled
service nginx restart
gunicorn --bind unix:/var/www/deepquote/deepquote.sock --workers 5 -k gevent wsgi
