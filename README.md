# Dancing Koala

## Overview

When your best friend is asking for a service, you cannot refuse `¯\_(ツ)_/¯`.

## Prerequisites

WIP

OR

- Docker :smirk:

## Install dependencies

WIP

## Run locally

After installing the dependencies, run:
```
WIP
```

## Run tests

After installing the dependencies, run:
```
WIP
```

## Troubleshooting

Create a Postgres user:
```
psql -U postgres
> CREATE DATABASE koala_dev;
> CREATE USER koala WITH PASSWORD password;
> GRANT ALL PRIVILEGES ON DATABASE koala_dev TO koala;
> ALTER USER koala CREATEDB;
> \q
```
