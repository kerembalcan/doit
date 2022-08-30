defmodule DoitWeb.Auth.CredentialsCheck do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Ecto.Query

  alias Doit.Accounts.User

  defp get_user_by_email(email, repo) do
    from(u in User, where: u.email == ^email and u.is_deleted == false) |> repo.one
  end

  def login_by_email_and_pass(email, pass, repo) do
    user = get_user_by_email(email, repo)

    cond do
      !is_nil(user) and is_nil(user.password_hash) ->
        {:error, "Password must be renewed"}

      user && checkpw(pass, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        dummy_checkpw()
        {:error, :not_found}
    end
  end

  def sign_in(conn, user) do
    Guardian.Plug.sign_in(conn, user, :token, perms: %{default: [:default]})
  end
end