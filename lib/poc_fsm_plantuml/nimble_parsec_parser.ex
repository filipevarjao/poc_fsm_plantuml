defmodule PocFsmPlantuml.NimbleParsecParser do
  @moduledoc false
  import NimbleParsec

  starting_ending_point = string("[*]") |> label("[*]")
  whitespace = ascii_char([?\s, ?\t]) |> times(min: 1)
  newline = string("\n") |> label("\n")

  state =
    ignore(optional(newline))
    |> ascii_string([?a..?z, ?A..?Z, ?0..?9], min: 1)
    |> ignore(optional(newline))

  transaction = string("-->") |> label("-->")

  string =
    ignore(string("@startuml\n"))
    |> ignore(starting_ending_point)
    |> ignore(optional(whitespace))
    |> choice([
        state,
        transaction,
      ])
    |> ignore(optional(whitespace))
    |> concat(starting_ending_point)
    |> ignore(string("\n@enduml\n"))

  defparsec :plantuml, string
end
