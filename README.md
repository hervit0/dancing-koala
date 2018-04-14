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

### Served routes

```
       page_path  GET     /                                   KoalaWeb.PageController :index
       page_path  POST    /                                   KoalaWeb.PageController :login
       page_path  POST    /logout                             KoalaWeb.PageController :logout
       page_path  GET     /secret                             KoalaWeb.PageController :secret
      event_path  GET     /events                             KoalaWeb.EventController :index
      event_path  GET     /events/:id/edit                    KoalaWeb.EventController :edit
      event_path  GET     /events/new                         KoalaWeb.EventController :new
      event_path  GET     /events/:id                         KoalaWeb.EventController :show
      event_path  POST    /events                             KoalaWeb.EventController :create
      event_path  PATCH   /events/:id                         KoalaWeb.EventController :update
                  PUT     /events/:id                         KoalaWeb.EventController :update
      event_path  DELETE  /events/:id                         KoalaWeb.EventController :delete
event_entry_path  GET     /events/:event_id/entries           KoalaWeb.EntryController :index
event_entry_path  GET     /events/:event_id/entries/:id/edit  KoalaWeb.EntryController :edit
event_entry_path  GET     /events/:event_id/entries/new       KoalaWeb.EntryController :new
event_entry_path  GET     /events/:event_id/entries/:id       KoalaWeb.EntryController :show
event_entry_path  POST    /events/:event_id/entries           KoalaWeb.EntryController :create
event_entry_path  PATCH   /events/:event_id/entries/:id       KoalaWeb.EntryController :update
                  PUT     /events/:event_id/entries/:id       KoalaWeb.EntryController :update
event_entry_path  DELETE  /events/:event_id/entries/:id       KoalaWeb.EntryController :delete
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
- [How to test Guardian?](https://stackoverflow.com/questions/37557737/stub-guardian-plug-ensureauthenticated-for-phoenix-controller-testing)
