# Docker potsgis

this container brings :

- postgres 11.5 on alphine 3.10
- postgis 2.5.3

As this is built on top of the postgres official images please refer to https://hub.docker.com/_/postgres/ for more informations.

Postgis is installed but not linked with postgres. you must enable the extensions per your requirement.

NB:

- EXPOSED PORT is the standard 5432
- PGDATA is /var/lib/postgresql/data and can be mount on host
- VOLUME /usr/share/data is shared to easly share files from the host to the container.

## run

> $ docker run --name pgsql -p 5432:5432 -v `pwd`/data:/usr/share/data -e POSTGRES_DB=demo -e POSTGRES_PASSWORD=mySuper$ecretPassw0rd -d tsamaya/docker-postgis

Sharing db VOLUME:

> $ docker run --name pgsql -p 5432:5432 -v `pwd`/data:/usr/share/data -v `pwd`/data/db:/var/lib/postgresql/data -e POSTGRES_DB=demo -e POSTGRES_PASSWORD=mySuper$ecretPassw0rd -d tsamaya/docker-postgis

## build your own image

clone this repo

> docker build -t \<repo\>/postgis .

## Licence

MIT
