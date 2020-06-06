# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

# database_url =
#   System.get_env("DATABASE_URL") ||
#     raise """
#     environment variable DATABASE_URL is missing.
#     For example: ecto://USER:PASS@HOST/DATABASE
#     """

config :hello, Hello.Repo,
  # https://cloud.google.com/community/tutorials/elixir-phoenix-on-kubernetes-google-container-engine
  # ssl: true,
  # url: database_url,
  # pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
  username: "postgres",
  password: "password",
  database: "hello",
  # hostname: "127.0.0.1",
  socket_dir: "/tmp/cloudsql/devs-sandbox:us-central1:hellodb",
  pool_size: 15

secret_key_base =
  "cmBJQ62yT46os2sJf+nqXm/dayP8tYOiI84V3kE3W26YcZNAfyasRanxdGX3+tP1"
  # System.get_env("SECRET_KEY_BASE") ||
  #   raise """
  #   environment variable SECRET_KEY_BASE is missing.
  #   You can generate one by calling: mix phx.gen.secret
  #   """

config :hello, HelloWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :hello, HelloWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
