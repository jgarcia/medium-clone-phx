defmodule Medium.User do
  use Medium.Web, :model
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]
  alias Ecto.Changeset

  schema "users" do
    field :name, :string
    field :username, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    has_many :posts, Medium.Post

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :username])
    |> validate_required([:name, :username])
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, ~w(password))
    |> validate_length(:password, min: 6, max: 100)
    |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    case changeset do
      %Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
