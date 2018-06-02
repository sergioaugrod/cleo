defmodule RabbitMQ.Consumer do
  alias Cleo.Intent

  use GenServer
  use AMQP

  require Logger

  @queue "intent"

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(chan: chan) do
    {:ok, _consumer_tag} = Basic.consume(chan, @queue)

    {:ok, chan}
  end

  def handle_info({:basic_consume_ok, %{consumer_tag: _consumer_tag}}, chan) do
    {:noreply, chan}
  end

  def handle_info({:basic_cancel, %{consumer_tag: _consumer_tag}}, chan) do
    {:stop, :normal, chan}
  end

  def handle_info({:basic_cancel_ok, %{consumer_tag: _consumer_tag}}, chan) do
    {:noreply, chan}
  end

  def handle_info({:basic_deliver, payload, %{delivery_tag: tag}}, chan) do
    spawn(fn ->
      try do
        Logger.info("[#{__MODULE__}]: consume message #{payload}.")
        Intent.execute(Poison.decode!(payload, keys: :atoms!))
        :ok = Basic.ack(chan, tag)
      rescue
        _error ->
          :ok = Basic.reject(chan, tag, requeue: false)
      end
    end)

    {:noreply, chan}
  end
end
