defmodule DoitWeb.GraphQL.Schema do
  use Absinthe.Schema
  alias DoitWeb.GraphQL.Resolvers

  import_types DoitWeb.GraphQL.Types.PostsTypes
  query do
    @desc "get list of tasks"
    field :tasks, list_of(:task) do
      resolve &Resolvers.Posts.tasks/3
    end
  end
end