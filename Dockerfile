# Docker for Sketchy
# Author : Scott, Nag
FROM ubuntu:14.04
MAINTAINER Nag <nagwww@gmail.com>


#For postgres installations
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 &&\
    echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list &&\
    apt-get update -y &&\
    apt-get -y -q install python-software-properties software-properties-common wget &&\
    apt-get install -y python-pip python-dev python-psycopg2 libpq-dev nginx supervisor git curl &&\
    apt-get -y install libmysqlclient-dev libxslt-dev libxml2-dev libfontconfig1 redis-server &&\
    wget -O /usr/local/share/phantomjs-1.9.7-linux-x86_64.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2 &&\
        tar -xf /usr/local/share/phantomjs-1.9.7-linux-x86_64.tar.bz2 -C /usr/local/share/ &&\
        ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs

# Expose the PostgreSQL port
EXPOSE 443
EXPOSE 8000


USER root
ADD sketchy.sh /home/ubuntu/

RUN useradd -d /home/ubuntu -m -s /bin/bash ubuntu &&\
    chmod -R 755 /home/ubuntu &&\
    chown -R ubuntu:ubuntu /home/ubuntu

USER ubuntu
RUN  git clone https://github.com/Netflix/sketchy.git /home/ubuntu/sketchy 

USER root
RUN    cd /home/ubuntu/sketchy && python setup.py install &&\
       su ubuntu -c "python /home/ubuntu/sketchy/manage.py create_db" &&\
       chmod 755 /home/ubuntu/sketchy.sh
#    service redis-server stop

#USER ubuntu
#RUN cd /home/ubuntu/sketchy &&\
#    python manage.py create_db

ADD supervisord.ini /home/ubuntu/sketchy/supervisor/
ADD sketchy.conf /etc/nginx/sites-available/
CMD /home/ubuntu/sketchy.sh
