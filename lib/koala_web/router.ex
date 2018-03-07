defmodule KoalaWeb.Router do
  use KoalaWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :auth do
    plug(Koala.Auth.Pipeline)
  end

  pipeline :ensure_auth do
    plug(Guardian.Plug.EnsureAuthenticated)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", KoalaWeb do
    pipe_through([:browser, :auth])

    get("/", PageController, :index)
    post("/", PageController, :login)
    post("/logout", PageController, :logout)
  end

  scope "/", KoalaWeb do
    pipe_through([:browser, :auth, :ensure_auth])

    get("/secret", PageController, :secret)

    resources "/events", EventController do
      resources("/entries", EntryController)
    end
  end
end
