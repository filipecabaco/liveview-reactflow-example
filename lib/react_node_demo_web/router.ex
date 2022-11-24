defmodule ReactNodeDemoWeb.Router do
  use ReactNodeDemoWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {ReactNodeDemoWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", ReactNodeDemoWeb do
    pipe_through(:browser)

    live("/", PageLive, :home)
  end

  # Other scopes may use custom stacks.
  # scope "/api", ReactNodeDemoWeb do
  #   pipe_through :api
  # end
end
