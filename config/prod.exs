use Mix.Config

config :cleo,
  telegram_allowed_chat_id: "${CLEO_TELEGRAM_ALLOWED_CHAT_ID}"

config :nadia,
  token: "${CLEO_TELEGRAM_TOKEN}"

config :amqp,
  uri: "${CLEO_RABBITMQ_URI}"
