defmodule KoalaWeb.Router do
  use KoalaWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", KoalaWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)

    resources "/events", EventController do
      resources("/entries", EntryController)
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", KoalaWeb do
  #   pipe_through :api
  # end
end
