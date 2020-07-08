Usage:

    host$ docker build -t dev .
    host$ dev-run
    host$ docker attach dev
    container$ tmux # or just vim

If disconnected:

    host$ docker attach dev

If the container is stopped:

    host$ docker container start dev
    host$ docker attach dev
