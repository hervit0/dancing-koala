import Ecto
import Ecto.Query

alias Koala.Repo
alias Koala.Events.Event
alias Koala.Entries.Entry
alias Koala.Auth
alias Koala.Auth.User

# Auth.create_user(%{username: "admin", password: "obvious"})
