defmodule AdventOfCode.Year2022.Day04 do
  @moduledoc """
  Given a paired assignment like this:

  2-4,7-8 (rooms 2-4, rooms 7-8)

  Part 1: Determine if one assignment fully encloses the other
  """
  def calc_part_1(inputs) do
    inputs
    |> Enum.map(&parse_line/1)
    |> Enum.filter(fn set -> fully_overlapping_assignment?(set) end)
    |> length()
  end

  def calc_part_2(inputs) do
    inputs
    |> Enum.map(&parse_line/1)
    |> Enum.filter(fn set -> partially_overlapping_assignment?(set) end)
    |> length()
  end

  def collect_input() do
    AdventOfCode.InputHelper.input_for(2022, 4)
    |> String.split("\n", trim: true)
  end

  # Return true if A or B fully contain the other
  def fully_overlapping_assignment?({a, b}) do
    intersection = MapSet.intersection(a, b)

    intersection == a || intersection == b
  end

  def partially_overlapping_assignment?({a, b}) do
    intersection = MapSet.intersection(a, b)

    Enum.any?(intersection)
  end

  def parse_line(line) do
    line
    |> String.split(",", trim: true)
    |> Enum.map(&mapset_from_str/1)
    |> List.to_tuple()
  end

  # Turn "1-7" into a Mapset<1..7>
  defp mapset_from_str(str) do
    [a, b] = String.split(str, "-", trim: true)

    range_begin = String.to_integer(a)
    range_end = String.to_integer(b)

    range_begin..range_end
    |> MapSet.new()
  end
end
