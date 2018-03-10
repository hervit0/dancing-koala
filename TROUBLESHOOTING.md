# Troubleshooting

### Add a Postgres user

Create a Postgres user:
```
psql -U postgres
> CREATE DATABASE koala_dev;
> CREATE USER koala WITH PASSWORD password;
> GRANT ALL PRIVILEGES ON DATABASE koala_dev TO koala;
> ALTER USER koala CREATEDB;
> \q
```

### Deployement notes

Deployement preparation:
```
heroku create --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git"
heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git
heroku addons:create heroku-postgresql:hobby-dev
heroku config:set POOL_SIZE=18
heroku config:set SECRET_KEY_BASE="xvafzY4y01jYuzLm3ecJqo008dVnU3CN4f+MamNd1Zue4pXvfvUjbiXT8akaIF53"
```

(And no it's not that secret.)

Deploy:
```
git push heroku master
```

```
heroku run MIX_ENV=prod mix ecto.migrate
heroku run MIX_ENV=prod mix run priv/repo/seeds.exs
heroku run "POOL_SIZE=1 iex -S mix"
```
