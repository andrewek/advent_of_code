defmodule AdventOfCode.Year2015.Day16 do

  def identify(inputs, desired) do
    inputs
    |> reduce_lines()
    |> Enum.filter(fn(x) -> match_line?(x, desired) end)
  end

  def match_line?(candidate, desired) do
    (is_nil(candidate.akitas) || candidate.akitas == desired.akitas) and
    (is_nil(candidate.cars) || candidate.cars == desired.cars) and
    (is_nil(candidate.cats) || candidate.cats > desired.cats) and
    (is_nil(candidate.children) || candidate.children == desired.children) and
    (is_nil(candidate.goldfish) || candidate.goldfish < desired.goldfish) and
    (is_nil(candidate.perfumes) || candidate.perfumes == desired.perfumes) and
    (is_nil(candidate.pomeranians) || candidate.pomeranians < desired.pomeranians) and
    (is_nil(candidate.samoyeds) || candidate.samoyeds == desired.samoyeds) and
    (is_nil(candidate.trees) || candidate.trees > desired.trees) and
    (is_nil(candidate.vizslas) || candidate.vizslas == desired.vizslas)
  end

  def reduce_lines(input) do
    input
    |> String.split(~r/\n/)
    |> Enum.map(fn(line) -> reduce_line(line) end)
  end

  # Reduce a single line
  def reduce_line(line) do
    [_, id, items] = Regex.run(~r/Sue (\d+):\s*(.*)\r?/, line)

    attrs = remap_items(items)

    Map.merge(%{ id: String.to_integer(id)}, attrs)
  end

  # Given a string like "cars: 9, akitas: 2", remaps into %{cars: 9, akitas: 2}
  # with appropriate nil values for missing keys
  defp remap_items(item_string) do
    item_string
    |> String.split(~r/\s*,\s*/)
    |> Enum.map(fn(x) -> String.split(x, ~r/:\s*/) end)
    |> Enum.map(fn([k, v]) -> {String.to_atom(k), String.to_integer(v)} end )
    |> Enum.into(%{})
    |> defaults()
  end

  defp defaults(list) do
    Map.merge(defaults(), list)
  end

  defp defaults() do
   %{
     akitas: nil,
     cars: nil,
     cats: nil,
     children: nil,
     goldfish: nil,
     perfumes: nil,
     pomeranians: nil,
     samoyeds: nil,
     trees: nil,
     vizslas: nil
   }
  end
end
