defmodule NimbleParsecParser do
  use ExUnit.Case

  alias PocFsmPlantuml.NimbleParsecParser, as: Parser

  test "parsing minimum plantuml state diagram" do
    content = """
    @startuml
    [*] --> [*]
    @enduml
    """
    result = Parser.plantuml content
    assert result == {:ok, ["-->", "[*]"], "", %{}, {4, 30}, 30}
  end
end
