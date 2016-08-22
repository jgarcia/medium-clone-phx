defmodule Medium.SessionController do
  use Medium.Web, :controller
  alias Medium.User
  alias Medium.Auth

  def create(conn, %{"user" => user_params}) do
    %{"username" => username, "password" => password} = user_params
    case Auth.login_by_username_and_password(conn, username, password, repo: Repo) do
      {:ok, conn} ->
        conn
        |> redirect(to: "/")
      {:error, _reason, conn} ->
        conn
        |> render("page/login.html")
    end
  end
end
