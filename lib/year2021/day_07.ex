defmodule AdventOfCode.Year2021.Day07 do
  @moduledoc """
  https://adventofcode.com/2021/day/7
  """

  def part_2(inputs) do
    base = base_range(inputs)

    base
    |> Enum.map(fn({position, _val}) -> {position, sum_growing_distance(inputs, position)} end)
    |> Enum.reduce(fn(current, min) -> find_smallest(current, min) end)
  end

  def part_1(inputs) do
    base = base_range(inputs)

    base
    |> Enum.map(fn({position, _val}) -> {position, sum_distance(inputs, position)} end)
    |> Enum.reduce(fn(current, min) -> find_smallest(current, min) end)
  end

  def find_smallest({current_pos, current_dist}, {min_pos, min_dist}) do
    if current_dist < min_dist do
      {current_pos, current_dist}
    else
      {min_pos, min_dist}
    end
  end

  @doc """
  Build out basic range-holder - this index will just track distances
  """
  def base_range(input) do
    min = Enum.min(input)
    max = Enum.max(input)

    min..max
    |> Enum.reduce(%{}, fn(index, acc) -> Map.put(acc, index, 0) end)
  end

  # Linear distance
  def sum_distance(inputs, pos) do
    inputs
    |> Enum.map(fn(i) -> abs(i - pos) end)
    |> Enum.sum()
  end

  def sum_growing_distance(inputs, pos) do
    inputs
    |> Enum.map(fn(i) -> abs(i - pos) end)
    |> Enum.map(fn(i) -> Enum.sum(0..i) end)
    |> Enum.sum()
  end

  def collect_input() do
    AdventOfCode.InputHelper.input_for(2021, 7)
    |> String.split(",", trim: true)
    |> Enum.map(fn(el) -> String.to_integer(el) end)
  end
end
