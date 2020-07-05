FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y ruby tmux vim

RUN adduser --disabled-password --gecos '' developer
USER developer

WORKDIR /home/developer
