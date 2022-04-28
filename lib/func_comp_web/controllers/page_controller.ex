defmodule FuncCompWeb.PageController do
  use FuncCompWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", list: ["a", "b", "c"])
  end
end
