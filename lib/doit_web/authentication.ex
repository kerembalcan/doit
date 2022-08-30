defmodule DoitWeb.Authentication do
  alias DoitWeb.Oauth
  alias Doit.Accounts
  alias DoitWeb.Auth.CredentialsCheck
  alias Doit.Accounts.User

  def login(token, "facebook") do
    attrs = token
            |> Oauth.Facebook.get_info

    search_params = %{facebook_id: attrs.facebook_id email: attrs.email}

    Accounts.get_user_or_create(attrs, search_params)
  end

  def login(token, "google") do

  end

  def login(conn, email, pass, "default") do
    CredentialsCheck.login_by_email_and_pass(email, pass, Doit.Repo)
  end

  def login(conn, email, pass, "default_sign_up") do
    changeset = User.registration_changeset(%User{}, to_lower_case_user_params(%{"email" => email, "password" => pass}))

    case Repo.insert(changeset) do

      {:ok}
    end
  end

  def to_lower_case_user_params(user_params) do
    if user_params["email"] do
      email = String.downcase(user_params["email"])
      %{user_params | "email" => email}
    else
      user_params
    end
  end

end