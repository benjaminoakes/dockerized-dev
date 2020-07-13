FROM ubuntu:18.04

ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV DOCKER_GID 995
RUN groupadd --gid $DOCKER_GID docker

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
  tmux \
  tree \
  unar \
  vim \
  wget \
  zsh

RUN gem install --no-document homesick

RUN adduser --disabled-password --gecos '' --shell /usr/bin/zsh benjaminoakes
RUN adduser benjaminoakes docker

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

# I uploaded this build for armv7l
RUN mkdir "$HOME/bin"; cd "$HOME/bin"; if [ "$(uname --processor)" == "x86_64" ]; then wget 'https://github.com/tomnomnom/gron/releases/download/v0.6.0/gron-linux-amd64-0.6.0.tgz'; tar xvfz *.tgz; rm *.tgz; fi; if [ "$(uname --processor)" == "armv7l" ]; then wget 'https://github.com/tomnomnom/gron/files/4910130/gron-linux-armv7l-602235e.zip'; unzip *.zip; rm *.zip; fi

WORKDIR /home/benjaminoakes/workspace
CMD zsh
