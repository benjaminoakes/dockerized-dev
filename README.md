Usage:

    host$ docker build -t dev .
    host$ docker run --name dev-test -d -it dev
    host$ docker attach dev-test
    container$ tmux

From a new session:

    host$ docker attach dev-test
