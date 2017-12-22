# Use an official Python runtime as a parent image
FROM ubuntu:16.10

MAINTAINER Per Klaar, per.klaar@offerta.se

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV LANGUAGE C.UTF-8

# Set the working directory to /app
WORKDIR /var/www/deepquote

# Copy the current directory contents into the container at /app
ADD ./config /home/

# Copy the hellow world sample
ADD ./project /var/www/deepquote

VOLUME /var/www/deepquote

RUN apt-get update && apt-get install -y --no-install-recommends \
	apt-utils \
	locales \
	nano \
	curl \
	apt-transport-https \
	nginx

# Add locales for Swedish and English (required for MS ODBC install) and install python3 + ODBC drivers
RUN locale-gen en_US && locale-gen en_US.UTF-8 && locale-gen sv_SE && locale-gen sv_SE.UTF-8 && update-locale
RUN apt-get install -y python3.6 python3-pip && sh /home/config.sh && rm -f /home/Dockerfile

# Install any needed packages specified in requirements.txt
RUN pip3 install --upgrade pip && pip3 install --trusted-host pypi.python.org -r /home/requirements.txt && rm -f /home/requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME AlfredAdmin

# Launch start up script
CMD service nginx restart && gunicorn --bind unix:/var/www/deepquote/deepquote.sock --workers 5 -k gevent wsgi
