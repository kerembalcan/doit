defmodule DoitWeb.GraphQL.Schema do
  use Absinthe.Schema
  alias DoitWeb.GraphQL.Resolvers
  alias DoitWeb.GraphQL.Middleware

  import_types DoitWeb.GraphQL.Types.PostsTypes
  import_types DoitWeb.GraphQL.Types.AccountsTypes

  query do
    @desc "get list of tasks"
    field :tasks, list_of(:task) do
      middleware Middleware.Authorize
      resolve &Resolvers.Posts.tasks/3
    end
  end

  mutation do
    @desc "Login as a user"
    field :login, :user_session do
      arg :token, :string
      arg :email, :string
      arg :password, :string
      arg :provider, type: :provider
      resolve &Resolvers.Accounts.login/3
    end
  end
end