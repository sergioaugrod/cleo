defmodule Cleo.MixProject do
  use Mix.Project

  def project do
    [
      app: :cleo,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Cleo.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:amqp, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:nadia, "~> 0.4.3"}
    ]
  end
end
