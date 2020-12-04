defmodule AdventOfCode.Year2020.Day02 do
  def full_part_1() do
    collect_input()
    |> calc_part_1()
  end

  def full_part_2() do
    collect_input()
    |> calc_part_2()
  end

  def calc_part_1(inputs) do
    inputs
    |> Enum.filter(&p1_valid_password?/1)
    |> length()
  end

  def calc_part_2(inputs) do
    inputs
    |> Enum.filter(&p2_valid_password?/1)
    |> length()
  end

  def collect_input() do
    AdventOfCode.InputHelper.input_for(2020, 2)
    |> String.split("\n")
    |> Enum.map(fn(str) -> parse_str(str) end)
  end

  def p1_valid_password?(password_map) do
    %{
      min_count: min,
      max_count: max,
      character: character,
      password: password
    } = password_map

    char_count =
      password
      |> String.split("")
      |> Enum.count(fn(el) -> el == character end)

    char_count <= max and char_count >= min
  end

  def p2_valid_password?(password_map) do
    %{
      min_count: pos_1,
      max_count: pos_2,
      character: character,
      password: password
    } = password_map

    first = String.at(password, pos_1 - 1)
    second = String.at(password, pos_2 - 1)

    (first == character or second == character) and first != second
  end

  # Strings come in as "3-6 c: abcdefg"
  #
  # Becomes:
  # %{
  #   min_count: 3,
  #   max_count: 6,
  #   character: "c",
  #   password: "abcdefg"
  # }
  def parse_str(str) do
    [raw_min, raw_max, character, password] =
      Regex.run(~r/(\d+)-(\d+) (\w): (\w+)/, str, capture: :all_but_first)

    %{
      password: password,
      character: character,
      min_count: String.to_integer(raw_min),
      max_count: String.to_integer(raw_max)
    }
  end
end
