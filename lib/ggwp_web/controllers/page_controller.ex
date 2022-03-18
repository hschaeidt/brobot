defmodule GGWPWeb.PageController do
  use GGWPWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
