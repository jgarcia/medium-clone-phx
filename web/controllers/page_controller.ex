defmodule Medium.PageController do
  use Medium.Web, :controller

  def signup(conn, _params) do
    changeset = Medium.User.changeset(%Medium.User{})
    conn
    |> assign(:changeset, changeset)
    |> render("signup.html")
  end
end
