defmodule Medium.RegistrationController do
  use Medium.Web, :controller
  alias Medium.User

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> redirect(to: "/")
      {:error, changeset} ->
        render(conn, "page/index.html", changeset: changeset)
    end
  end
end
