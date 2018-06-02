defmodule Cleo.Invocation.Voice do
  alias Telegram.Client
  alias RabbitMQ.Producer

  def execute(%{file_id: file_id}) do
    file_id
    |> Client.get_file_link()
    |> send_voice()
  end

  defp send_voice({:ok, file_link}) do
    Map.new()
    |> Map.put(:voice, %{file_link: file_link})
    |> Poison.encode!()
    |> Producer.publish("invocation")
  end
end
