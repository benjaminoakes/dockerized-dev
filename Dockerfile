FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y tmux

RUN adduser --disabled-password --gecos '' developer
USER developer

WORKDIR /home/developer
