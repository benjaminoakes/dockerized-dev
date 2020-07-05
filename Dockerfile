FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y git ruby tmux vim
RUN gem install homesick

RUN adduser --disabled-password --gecos '' developer
USER developer

RUN homesick clone benjaminoakes/homesick-vi-everywhere
RUN homesick symlink homesick-vi-everywhere --force
RUN homesick clone ContinuityControl/dotfiles
RUN homesick symlink dotfiles --force

WORKDIR /home/developer
