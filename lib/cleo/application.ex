defmodule Cleo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias RabbitMQ.Connection
  alias Cleo.InvocationWorker

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Cleo.Worker.start_link(arg)
      {InvocationWorker, [offset: 0]},
      {Connection, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cleo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
