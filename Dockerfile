FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y \
  curl \
  git \
  man-db \
  openssh-client \
  ruby \
  tmux \
  vim \
  zsh

RUN gem install homesick

RUN adduser --disabled-password --gecos '' --shell /usr/bin/zsh developer
USER developer

RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
RUN homesick clone benjaminoakes/homesick-vi-everywhere
RUN homesick symlink homesick-vi-everywhere --force
RUN homesick clone ContinuityControl/dotfiles
RUN homesick symlink dotfiles --force

RUN mkdir -p ~/.zsh; echo 'source "$HOME/.personal/zsh/local.zsh"' > ~/.zsh/local.zsh
RUN mkdir -p ~/.gitconfig.d; printf "[include]\n  path = ~/.personal/gitconfig.d/user\n" > ~/.gitconfig.d/user
# Might later include my own tmux config but for now, stop its complaining
RUN mkdir -p ~/.tmux; echo '' > ~/.tmux/user.conf

WORKDIR /home/developer/workspace
