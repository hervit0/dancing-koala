defmodule Koala.Repo do
  use Ecto.Repo, otp_app: :koala

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    database_url = System.get_env("DATABASE_URL")
    {:ok, Keyword.put(opts, :url, database_url)}
  end
end
