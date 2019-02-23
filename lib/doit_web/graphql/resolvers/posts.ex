defmodule DoitWeb.GraphQL.Resolvers.Posts do

  def tasks(_,_,_) do
    {:ok, Doit.Posts.list_tasks}
  end

end
