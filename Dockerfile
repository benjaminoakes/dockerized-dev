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
  wget \
  zsh

RUN gem install --no-document homesick

RUN adduser --disabled-password --gecos '' --shell /usr/bin/zsh benjaminoakes
USER benjaminoakes

RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
RUN homesick clone benjaminoakes/homesick-vi-everywhere
RUN homesick symlink homesick-vi-everywhere --force
RUN homesick clone ContinuityControl/dotfiles
RUN homesick symlink dotfiles --force
# This colorscheme is causing problems on first run and doesn't look quite right yet
RUN sed -i "s/^colorscheme solarized8$/colorscheme desert/" ~/.vimrc
RUN vim -c 'PlugInstall --sync' -c 'qa'

RUN mkdir -p ~/.zsh; echo '' > ~/.zsh/local.zsh
RUN mkdir -p ~/.gitconfig.d; printf "\n" > ~/.gitconfig.d/user
# Might later include my own tmux config but for now, stop its complaining
RUN mkdir -p ~/.tmux; echo '' > ~/.tmux/user.conf
RUN git config --global user.name "Benjamin Oakes"
RUN git config --global user.email "hello@benjaminoakes.com"

WORKDIR /home/benjaminoakes/workspace
CMD zsh
