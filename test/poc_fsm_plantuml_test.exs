defmodule PocFsmPlantumlTest do
  use ExUnit.Case
  doctest PocFsmPlantuml

  alias PocFsmPlantuml.PlantumlParser, as: Parser

  setup do
    base_dir = Path.join([System.cwd!(), "test", "fixtures"])
    {:ok, base_dir: base_dir}
  end

  def parse(base_dir, file) do
    Path.join([base_dir, file])
    |> Parser.parse_file!()
  end

  test "parse a simple plantuml" do
    content = """
    @startuml
    [*] --> State1
    State1 --> [*]
    @enduml
    """

    result = Parser.parse_plantuml(content)

    assert result == [
      {"@startuml"},
      {"[*]", "-->", "State1"},
      {"State1", "-->", "[*]"},
      {"@enduml"}
    ]
  end

  test "parse PlantUml file", %{base_dir: base_dir} do
    result = parse(base_dir, "StateDiagram.plantuml")

    assert result == [
      {"@startuml"},
      {"[*]", "-->", "State1"},
      {"State1", "-->", "[*]"},
      {"@enduml"}
    ]
  end
end
