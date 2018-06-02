defmodule Cleo.Invocation do
  alias Telegram.Client
  alias Cleo.Invocation.{Text, Voice}

  def execute({:ok, []}), do: -1
  def execute({:error, _}), do: -1

  def execute({:ok, updates}) do
    updates
    |> Enum.map(& &1.message)
    |> Enum.filter(&(&1.from.id == Client.allowed_chat_id()))
    |> Enum.each(&execute_invocation(&1))

    List.last(updates).update_id
  end

  defp execute_invocation(%{voice: nil, text: text}) when is_binary(text) do
    Text.execute(text)
  end

  defp execute_invocation(%{voice: voice, text: nil}) when is_map(voice) do
    Voice.execute(voice)
  end
end
