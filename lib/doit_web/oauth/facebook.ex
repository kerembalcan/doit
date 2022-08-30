defmodule DoitWeb.Oauth.Facebook do
  @fields "id, email, first_name, last_name"

  def get_info(token) do
    token
    |> get_user
    |> normalize
  end

  defp get_user(token) do
    {:ok, user} = Facebook.me([fields: @fields], token)
    user
  end

  defp normalize(user) do
    %{
      facebook_id: user["id"],
      first_name: user["first_name"],
      last_name: user["last_name"],
      email: user["email"]
    }
  end

end