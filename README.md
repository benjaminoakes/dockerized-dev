Usage:

    host$ docker build -t dev .
    host$ docker run --name dev -v $PWD:/home/developer/workspace -d -it dev
    host$ docker attach dev
    container$ tmux

From a new session:

    host$ docker attach dev
