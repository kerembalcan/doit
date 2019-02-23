defmodule DoitWeb.GraphQL.Types.PostsTypes do
  use Absinthe.Schema.Notation

  object :task do
    field :id, non_null(:id)

    field :title, non_null(:string)
    field :description, :string

    field :inserted_at, non_null(:string)
    field :updated_at, non_null(:string)

  end
end