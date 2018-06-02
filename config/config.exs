use Mix.Config

config :cleo,
  message_worker_interval: 1,
  telegram_allowed_chat_id: System.get_env("CLEO_TELEGRAM_ALLOWED_CHAT_ID")

config :nadia,
  token: System.get_env("CLEO_TELEGRAM_TOKEN")

config :amqp,
  uri: "amqp://guest:guest@localhost"

config :lager,
  handlers: [level: :critical]

import_config "#{Mix.env()}.exs"
