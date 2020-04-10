defmodule GolExWeb.PageController do
  use GolExWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
