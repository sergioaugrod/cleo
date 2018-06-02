defmodule Cleo.Intent do
  alias Cleo.Intent.Welcome

  def execute(%{action: action, attributes: attributes}) do
    intent(String.to_atom(action), attributes)
  end

  defp intent(:welcome, attributes), do: Welcome.execute(attributes)
end
