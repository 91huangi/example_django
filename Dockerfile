# Begin Dockerfile
FROM ubuntu

RUN apt-get update -qy
RUN apt-get install apt-utils -qy
RUN apt-get install apache2 libapache2-mod-wsgi-py3 -qy
RUN apt-get install python3 python3-pip -qy

# I used mysql, but you can choose postgreSQL or whichever database you prefer
RUN apt-get install libmysqlclient-dev -qy

# Optionally symlinking python and pip so you can call without specifying "python3" or "pip3"
RUN ln /usr/bin/python3 /usr/bin/python
RUN ln /usr/bin/pip3 /usr/bin/pip

# Optional for more efficient python logging
ENV PYTHONUNBUFFERED 1

RUN mkdir /var/www/html/example_django
WORKDIR /var/www/html/example_django
COPY requirements.txt /var/www/html/example_django
RUN pip install -r requirements.txt
RUN apt-get update -qy
ADD ./apache/example_django.conf /etc/apache2/sites-available/000-default.conf
COPY . /var/www/html/example_django
