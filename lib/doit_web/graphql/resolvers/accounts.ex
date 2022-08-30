defmodule DoitWeb.GraphQL.Resolvers.Accounts do
  alias DoitWeb.{Authentication, Auth}

  def login(conn, info, _) do
    login_helper(conn, info)
  end


  defp login_helper(conn, %{token: token, provider: provider, email: email, password: password}) do
    case provider do
      :default ->
        case Authentication.login(conn, email, password, "default") do
          {:ok, user} ->
            {:ok, token, _} = Auth.Guardian.encode_and_sign(user)
            {:ok, %{token: token}}

          {:error, error} ->
            case error do
              :not_found -> {:error, "Provided email password combination cannot be found"}
              _ -> {:error, error}
            end

        end

        :default_sign_up ->
          case Authentication.login(conn, email, password, "default_sign_up") do
            {:ok, user} ->
              {:ok, token, _} = Auth.Guardian.encode_and_sign(user)
              {:ok, %{token: token}}

            {:error, error} ->
              case error do
                :not_found -> {:error, "Provided email password combination cannot be found"}
                _ -> {:error, error}
              end

          end
        _ -> {:error, "Not an expected provider"}
    end
  end

  defp login_helper(conn, %{token: token, provider: provider}) do
    case provider do
      :facebook ->
        {:ok, user} = Authentication.login(token, "facebook")

        {:ok, token, _} = Auth.Guardian.encode_and_sign(user)

        {:ok, %{token: token}}

      _ -> {:error, "Not an expected provider"}
    end
  end

  defp sign_up_helper() do

  end
end
