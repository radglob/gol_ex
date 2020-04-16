defmodule GolExWeb.Router do
  use GolExWeb, :router

  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {GolExWeb.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GolExWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/gameoflife", GameOfLifeLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", GolExWeb do
  #   pipe_through :api
  # end
end
