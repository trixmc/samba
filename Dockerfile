FROM ubuntu
MAINTAINER Olexander Vdovychenko <farmazin@gmail.com>

#install Software
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y software-properties-common python-software-properties
RUN apt-get install -y vim nano mc screen curl unzip wget
RUN apt-get install -y samba samba-common python-glade2 system-config-samba

#SUMBA Config
RUN mv /etc/samba/smb.conf /etc/samba/smb.conf.bak
COPY configs/samba /etc/samba/smb.conf
RUN addgroup smbgrp
RUN mkdir -p /samba/secured
RUN chmod -R 0770 /samba/secured
RUN service smbd restart 

#open ports
EXPOSE 22 2222 2000 445 139