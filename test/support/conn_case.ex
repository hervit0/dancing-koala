defmodule KoalaWeb.ConnCase do
  alias Koala.Auth.Guardian
  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import KoalaWeb.Router.Helpers

      # The default endpoint for testing
      @endpoint KoalaWeb.Endpoint

      defp put_auth_header(%{conn: conn}) do
        Koala.Auth.create_user(%{username: "toto", password: "africa"})

        {:ok, conn: conn}
      end
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Koala.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Koala.Repo, {:shared, self()})
    end

    {conn, user} =
      if tags[:authenticated] do
        {:ok, user} = Koala.Auth.create_user(%{username: "toto", password: "africa"})

        conn =
          Phoenix.ConnTest.build_conn()
          |> Guardian.Plug.sign_in(user)

        {conn, user}
      else
        {Phoenix.ConnTest.build_conn(), nil}
      end

    {:ok, conn: conn, user: user}
  end
end
