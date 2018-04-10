# Dancing Koala

## Overview

Still in WIP.

When your best friend is asking for a service, you cannot refuse `¯\_(ツ)_/¯`.

Dancing Koala is an Elixir webapp, using the Phoenix framework. It has been developed under Docker and it's using to CircleCI to ensure continuous delivery towards the Heroku platform.

## Prerequisites

- [`docker-compose`](https://docs.docker.com/compose/install/#install-compose)
- [dex bash](https://github.com/Driftrock/dex/blob/master/dex) and its dependencies

## Run locally

### On the raw OS (not recommended)

Hum, too much stuff required, keep reading.

### With Docker (not recommended)

Not recommended as you will need to configure a Postgres instance on you local.
```
docker build --no-cache -t dancing-koala .
docker run -it --rm -p 8080:8080 dancing-koala
```

### With Docker Compose (not recommended)

Run: `docker-compose up`

Seed the DB if needed:
```
docker exec -it $(docker ps -aqf "name=dancingkoala_dancing-koala" | head -1) sh
mix run priv/repo/seeds.exs
```

### With Dex bash

```
dex bash
bash-4.4# mix ecto.create && mix ecto.migrate
bash-4.4# mix run priv/repo/seeds.exs
```

## Run tests

WIP

Run:
```
docker-compose -f docker-compose.test.yml run dancing-koala-test
```

## Acknowledgment

Used/inspiring resources:
- [Authentification layer](https://medium.com/@tylerpachal/session-authentication-example-for-phoenix-1-3-using-guardian-1-0-beta-a228c78478e6)
- [One-to-Many relationship](https://hackernoon.com/introduction-fe138ac6079d)
