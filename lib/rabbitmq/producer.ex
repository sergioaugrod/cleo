defmodule RabbitMQ.Producer do
  alias AMQP.Basic
  alias RabbitMQ.Connection

  require Logger

  def publish(body, queue) do
    Logger.info("[#{__MODULE__}]: publishing #{body} to #{queue}...")

    chan = Connection.get_channel()
    Basic.publish(chan, "#{queue}_exchange", "", body)
  end
end
