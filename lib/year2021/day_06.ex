defmodule AdventOfCode.Year2021.Day06 do
  @moduledoc """
  https://adventofcode.com/2021/day/6
  """

  def solve(inputs, day \\ 0, limit \\ 80)

  def solve(inputs, day, limit) when day == limit do
    inputs
    |> Enum.reduce(0, fn {_k, value}, acc -> acc + value end)
  end

  def solve(inputs, day, limit) do
    fishes = %{
      0 => inputs[1],
      1 => inputs[2],
      2 => inputs[3],
      3 => inputs[4],
      4 => inputs[5],
      5 => inputs[6],
      6 => inputs[0] + inputs[7],
      7 => inputs[8],
      8 => inputs[0]
    }

    solve(fishes, day + 1, limit)
  end

  def collect_input() do
    AdventOfCode.InputHelper.input_for(2021, 6)
    |> String.split(",")
    |> Enum.map(fn el -> String.to_integer(el) end)
    |> Enum.frequencies()
    |> Enum.into(%{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0})
  end
end
