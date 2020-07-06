Usage:

    host$ docker build -t dev .
    host$ docker run --name dev \
      --hostname dev \
      --privileged \
      -v `readlink -f /var/run/docker.sock`:/var/run/docker.sock \
      -v $PWD:/home/developer/workspace \
      -v $SSH_AUTH_SOCK:$SSH_AUTH_SOCK \
      -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK \
      --rm \
      -d -it dev
    host$ docker attach dev
    container$ tmux

From a new session:

    host$ docker attach dev
