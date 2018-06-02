defmodule Telegram.Client do
  def get_updates(options) do
    Nadia.get_updates(options)
  end

  def send_message(message) do
    Nadia.send_message(allowed_chat_id(), message)
  end

  def get_file_link(file_id) do
    {:ok, file} = Nadia.get_file(file_id)
    Nadia.get_file_link(file)
  end

  def allowed_chat_id do
    chat_id = Application.get_env(:cleo, :telegram_allowed_chat_id)

    case Integer.parse(chat_id) do
      {number, _} -> number
    end
  end
end
