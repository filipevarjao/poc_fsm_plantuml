defmodule PocFsmPlantuml do
  @moduledoc """
  Documentation for PocFsmPlantuml.
  """

  @doc """
  Hello world.

  ## Examples

      iex> PocFsmPlantuml.hello()
      :world

  """
  def hello do
    :world
  end

  @doc """
  We are assuming the plantuml file is correct.
  """
  def parse_plantuml(input) do
    puml = input
    |> String.split("\n")
    |> Enum.map(fn x -> String.split(x, " ") end)

    for i <- puml, i != [""], do: List.to_tuple(i)
  end
end
