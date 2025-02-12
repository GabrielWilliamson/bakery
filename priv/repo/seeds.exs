alias Bakery.Repo
alias Bakery.Units.Unit

unit_seeds = [
  %{name: "gramo", short: "g"},
  %{name: "kilogramo", short: "kg"},
  %{name: "libra", short: "lb"},
  %{name: "onza", short: "oz"},
  %{name: "mililitro", short: "ml"},
  %{name: "litro", short: "l"}
]

for unit <- unit_seeds do
  Repo.get_by(Unit, short: unit[:short]) ||
    %Unit{}
    |> Unit.changeset(unit)
    |> Repo.insert!()
end
