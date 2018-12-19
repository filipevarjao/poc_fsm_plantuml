defmodule PocFsmPlantumlTest do
  use ExUnit.Case
  doctest PocFsmPlantuml

  test "greets the world" do
    assert PocFsmPlantuml.hello() == :world
  end

  test "parse a simple plantuml" do
    content = """
    @startuml
    [*] --> State1
    State1 --> [*]
    @enduml
    """

    result = PocFsmPlantuml.parse_plantuml(content)

    assert result == [
      {"@startuml"},
      {"[*]", "-->", "State1"},
      {"State1", "-->", "[*]"},
      {"@enduml"}
    ]
  end
end
