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
RUN service samba restart 

# SSH service
RUN sudo apt-get install -y openssh-server openssh-client
RUN sudo mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
#change 'pass' to your secret password
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

#configs bash start
COPY configs/autostart.sh /root/autostart.sh
RUN chmod +x /root/autostart.sh
COPY configs/bash.bashrc /etc/bash.bashrc

#Add colorful command line
RUN echo "force_color_prompt=yes" >> .bashrc
RUN echo "export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'" >> .bashrc

#etcKeeper
RUN mkdir -p /root/etckeeper
COPY configs/etckeeper.sh /root
COPY configs/files/etckeeper-hook.sh /root/etckeeper
RUN /root/etckeeper.sh

#open ports
EXPOSE 22 445