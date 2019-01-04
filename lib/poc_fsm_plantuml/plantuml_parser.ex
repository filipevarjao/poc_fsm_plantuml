defmodule PocFsmPlantuml.PlantumlParser do
  # import NimbleParsec

  @moduledoc """
  Documentation for PocFsmPlantuml.
  Supported Formats *.wsd, *.pu, *.puml, *.plantuml, *.iuml
  """

  @doc """
  We are assuming the plantuml file is correct.
  """
  def parse_file!(path) do
    path
    |> File.read!()
    |> parse_plantuml()
  end

  def parse_content!(content), do: parse_plantuml(content)

  def parse_plantuml(input) do
    puml = input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> String.split(x, " ") end)

    for i <- puml, i != [""], do: List.to_tuple(i)
  end
end
