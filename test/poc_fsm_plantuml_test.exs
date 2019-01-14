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

  test "parse a CoffeeMachine Diagram file", %{base_dir: base_dir} do
    result = parse(base_dir, "CoffeeStateDiagram.plantuml")
    assert result == [
      {"@startuml"},
      {"[*]", "-->", "SelectionState"},
      {"state", "SelectionState", "{"},
      {"[*]", "-->", "SelectionDisplay"},
      {"SelectionState", "-->", "SelectionDisplay:", "prompts_for_selection"},
      {"}"},
      {"state", "PaymentState", "{"},
      {"PaymentState", "-->", "PaymentDisplay"},
      {"PaymentDisplay:", "entry/", "enter_payment_state"},
      {"PaymentDisplay:", "do/", "display_price"},
      {"PaymentDisplay:", "exit/", "left_payment_state"},
      {"}"},
      {"state", "RemoveState", "{"},
      {"RemoveState", "-->", "RemoveDisplay"},
      {"}"},
      {"SelectionState", "-->", "SelectionState:", "presses_cancel"},
      {"SelectionState", "-->", "PaymentState:", "makes_selection"},
      {"PaymentState", "-->", "RemoveState:", "drops_coun"},
      {"PaymentState", "-->", "SelectionState:", "presses_cancel"},
      {"RemoveState","-->", "SelectionState:", "takes_coffee"},
      {"@enduml"}
    ]
  end
end
