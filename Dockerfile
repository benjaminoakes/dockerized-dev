FROM ubuntu:18.04

ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install -y \
  ctop \
  curl \
  docker.io \
  git \
  jq \
  man-db \
  openssh-client \
  rlwrap \
  ruby \
  sudo \
  tmux \
  tree \
  unar \
  vim \
  wget \
  zsh

RUN gem install --no-document homesick

RUN adduser --disabled-password --gecos '' --shell /usr/bin/zsh benjaminoakes
RUN adduser benjaminoakes sudo

# Needed for `sudo` for docker because the user doesn't have a password
#
# From https://github.com/AGhost-7/docker-dev/blob/master/tutorial/readme.md
#
#     Give passwordless sudo. This is only acceptable as it is a private
#     development environment not exposed to the outside world. Do NOT do this on
#     your host machine or otherwise.
#
# Instead, this is limited to 1 user to allow /usr/bin/docker.  If the docker
# group (and its GID) can be used, sudo may become unnecessary.
RUN echo 'benjaminoakes ALL=(ALL) NOPASSWD: /usr/bin/docker' >> /etc/sudoers

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
