defmodule DoitWeb.Router do
  use DoitWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug DoitWeb.Context
  end

  scope "/", DoitWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
      schema: DoitWeb.GraphQL.Schema

      if Mix.env == :dev do
        forward "/graphql", Absinthe.Plug.GraphiQL,
          schema: DoitWeb.GraphQL.Schema
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", DoitWeb do
  #   pipe_through :api
  # end
end
