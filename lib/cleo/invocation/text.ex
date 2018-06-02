defmodule Cleo.Invocation.Text do
  alias RabbitMQ.Producer

  def execute(text) do
    send_text(text)
  end

  defp send_text(text) do
    Map.new()
    |> Map.put(:text, %{payload: text})
    |> Poison.encode!()
    |> Producer.publish("invocation")
  end
end
