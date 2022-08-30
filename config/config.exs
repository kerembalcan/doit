# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :doit,
  ecto_repos: [Doit.Repo]

# Configures the endpoint
config :doit, DoitWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pT9BsvsN+sKICSapEpY0KKosV2QcKnpWVAH+0Ph+gdRe+jyvtGg5eXCp96Hb09qM",
  render_errors: [view: DoitWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Doit.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Configures Guardian
config :doit, DoitWeb.Auth.Guardian,
  issuer: "doit",
  verify_issuer: true,
  secret_key: "SroHPOVZiU1Zqxzdu6zwDSOHlicafsnKAESvW0hroKhowVIO4AYIq4FcQDja/c03",
  permissions: %{
    default: [:default],
    admin: [:admin]
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
