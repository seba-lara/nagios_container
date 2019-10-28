# Nagios server with web config UI

FROM smeretech/docker-debian-nagios:latest
MAINTAINER Stefano Mereghetti <docker@smereghetti.com>

## Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq
RUN apt-get install -y mailutils ssmtp php5-ssh2 php5-mysql nano ssh

# Download NagiosQL
RUN mkdir /download
ADD http://downloads.sourceforge.net/project/nagiosql/nagiosql/NagiosQL%203.2.0/nagiosql_320.tar.gz /download/nagiosql_320.tar.gz
WORKDIR /download
RUN tar xvzf nagiosql_320.tar.gz
WORKDIR /

# Install
RUN mv /download/nagiosql32 /usr/local/nagiosql
ADD nagiosql.conf /etc/apache2/conf-available/nagiosql.conf
RUN a2enconf nagiosql

# Configure
RUN ln -s /opt/nagios/etc /etc/nagios
RUN ln -s /opt/nagios/var /var/nagios
#RUN ln -s /usr/local/nagios /opt/nagios
ADD settings.php /usr/local/nagiosql/config/settings.php
ADD etc /etc/nagiosql
ADD nagioscfg.append /nagioscfg.append
ADD confignagiosql.sh /confignagiosql.sh
RUN /confignagiosql.sh
RUN /opt/nagios/bin/nagios -v /opt/nagios/etc/nagios.cfg

# Patch PHP's config
RUN sed -e 's/;date.timezone =/date.timezone = UTC/' /etc/php5/apache2/php.ini > /tmp.ini
RUN mv /tmp.ini /etc/php5/apache2/php.ini

# Cleanup
RUN rm -rf /download
RUN rm -f /nagioscfg.append
RUN rm -f /confignagiosql.sh
