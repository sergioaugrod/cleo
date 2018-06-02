defmodule Cleo.Intent.Welcome do
  alias Telegram.Client

  def execute(%{name: name}) do
    Client.send_message("Hello #{name}.")
  end
end
