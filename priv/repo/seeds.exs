alias Koala.Repo
alias Koala.Auth
alias Koala.Auth.User

Repo.delete_all User
username = Map.fetch!(System.get_env(), "ADMIN_USERNAME")
password = Map.fetch!(System.get_env(), "ADMIN_PASSWORD")
Auth.create_user(%{username: username, password: password})
