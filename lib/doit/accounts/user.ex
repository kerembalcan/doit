defmodule Doit.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :facebook_id, :string
    field :first_name, :string
    field :last_name, :string

    field :password_hash, :string
    field :is_deleted, :boolean

    timestamps()
  end

  @doc false

  def registration_changeset(model, params \\ %{}) do
    model
    |> changeset(params)
    |> new_password_changeset(params)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :facebook_id, :email])
    |> validate_required([:first_name, :last_name, :facebook_id, :email, :password_hash])
    |> unique_constraint(:email)
  end

  def new_password_changeset(model, params) do
    model
    |> cast(params, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  def put_pass_hash(changeset, field \\ :password, field_hash \\ :password_hash) do
    if changeset.valid? do
      case get_change(changeset, field) do
        nil ->
          changeset

        password ->
          put_change(changeset, field_hash, Comeonin.Bcrypt.hashpwsalt(password))
      end
    else
      changeset
    end
  end
end
