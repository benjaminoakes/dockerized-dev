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

RUN mkdir -p ~/.zsh; echo 'source "$HOME/.personal/zsh/local.zsh"' > ~/.zsh/local.zsh
RUN mkdir -p ~/.gitconfig.d; printf "[include]\n  path = ~/.personal/gitconfig.d/user\n" > ~/.gitconfig.d/user
# Might later include my own tmux config but for now, stop its complaining
RUN mkdir -p ~/.tmux; echo '' > ~/.tmux/user.conf

USER root

RUN apt-get install -y curl man-db openssh-client zsh

USER developer

WORKDIR /home/developer/workspace
