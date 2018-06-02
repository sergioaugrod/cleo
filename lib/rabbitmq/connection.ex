defmodule RabbitMQ.Connection do
  alias RabbitMQ.Consumer

  use GenServer
  use AMQP

  require Logger

  @queues ["invocation", "intent"]

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    connect()
  end

  def get_channel do
    GenServer.call(__MODULE__, :get_channel)
  end

  def handle_call(:get_channel, _from, chan) do
    {:reply, chan, chan}
  end

  def handle_info({:DOWN, _, :process, _pid, _reason}, _) do
    {:ok, chan} = connect()
    {:noreply, chan}
  end

  defp connect do
    case Connection.open(uri()) do
      {:ok, conn} ->
        Process.monitor(conn.pid)

        {:ok, chan} = Channel.open(conn)
        setup_queues(chan)

        Logger.info("[#{__MODULE__}]: Connected with #{uri()}.")
        Consumer.start_link(chan: chan)
        {:ok, chan}

      {:error, _reason} ->
        :timer.sleep(10000)
        connect()
    end
  end

  defp setup_queues(chan) do
    Enum.each(@queues, fn queue ->
      {:ok, _} = Queue.declare(chan, "#{queue}_error", durable: true)

      {:ok, _} =
        Queue.declare(
          chan,
          queue,
          durable: true,
          arguments: [
            {"x-dead-letter-exchange", :longstr, ""},
            {"x-dead-letter-routing-key", :longstr, "#{queue}_error"}
          ]
        )

      :ok = Exchange.fanout(chan, "#{queue}_exchange", durable: true)
      :ok = Queue.bind(chan, queue, "#{queue}_exchange")
    end)
  end

  defp uri, do: Application.get_env(:amqp, :uri)
end
