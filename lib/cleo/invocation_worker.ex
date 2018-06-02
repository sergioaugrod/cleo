defmodule Cleo.InvocationWorker do
  use GenServer

  alias Telegram.Client
  alias Cleo.Invocation

  def start_link(state \\ [offset: 0]) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, offset: offset) do
    offset =
      [offset: offset]
      |> Client.get_updates()
      |> Invocation.execute()

    schedule_work()
    {:noreply, [offset: offset + 1]}
  end

  defp schedule_work, do: Process.send_after(self(), :work, 1000 * interval())

  defp interval, do: Application.get_env(:cleo, :message_worker_interval)
end
