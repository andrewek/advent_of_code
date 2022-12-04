defmodule AdventOfCode.Year2022.Day03 do
  @moduledoc """

  Knapsack something or other

  https://adventofcode.com/2022/day/3
  """

  @priorities %{
    "a" => 1,
    "b" => 2,
    "c" => 3,
    "d" => 4,
    "e" => 5,
    "f" => 6,
    "g" => 7,
    "h" => 8,
    "i" => 9,
    "j" => 10,
    "k" => 11,
    "l" => 12,
    "m" => 13,
    "n" => 14,
    "o" => 15,
    "p" => 16,
    "q" => 17,
    "r" => 18,
    "s" => 19,
    "t" => 20,
    "u" => 21,
    "v" => 22,
    "w" => 23,
    "x" => 24,
    "y" => 25,
    "z" => 26,
    "A" => 27,
    "B" => 28,
    "C" => 29,
    "D" => 30,
    "E" => 31,
    "F" => 32,
    "G" => 33,
    "H" => 34,
    "I" => 35,
    "J" => 36,
    "K" => 37,
    "L" => 38,
    "M" => 39,
    "N" => 40,
    "O" => 41,
    "P" => 42,
    "Q" => 43,
    "R" => 44,
    "S" => 45,
    "T" => 46,
    "U" => 47,
    "V" => 48,
    "W" => 49,
    "X" => 50,
    "Y" => 51,
    "Z" => 52
  }

  @doc """
  """
  def calc_part_1(inputs) do
    inputs
    |> Enum.map(&score_knapsack/1)
    |> Enum.sum()
  end

  @doc """

  """
  def calc_part_2(inputs) do
    inputs
    |> Enum.chunk_every(3)
    |> Enum.map(&score_chunk/1)
    |> Enum.sum()
  end

  def score_chunk(chunks) do
    chunks
    |> Enum.map(&transform_subchunk/1)
    |> Enum.reduce(fn(el, acc) -> MapSet.intersection(el, acc) end)
    |> MapSet.to_list()
    |> Enum.map(&priority_of/1)
    |> Enum.sum()
  end

  def transform_subchunk(sub) do
    sub
    |> String.split("", trim: true)
    |> MapSet.new()
  end

  def collect_input() do
    AdventOfCode.InputHelper.input_for(2022, 3)
    |> String.split("\n", trim: true)
  end

  def full_part_1() do
    collect_input()
    |> calc_part_1()
  end

  def full_part_2() do
    collect_input()
    |> calc_part_2()
  end

  # PART 1
  def score_knapsack(line) do
    line
    |> split_knapsack()
    |> intersection()
    |> Enum.map(&priority_of/1)
    |> Enum.sum()
  end

  def split_knapsack(line) do
    line
    |> String.split("", trim: true)
    |> then(fn(list) ->
      split_pt = div(length(list), 2)

      [
        Enum.slice(list, 0, split_pt),
        Enum.slice(list, -split_pt, split_pt)
      ]
    end)
  end

  def intersection([a, b]) do
    set_a = MapSet.new(a)
    set_b = MapSet.new(b)

    MapSet.intersection(set_a, set_b)
    |> MapSet.to_list()
  end

  defp priority_of(char) do
    @priorities[char]
  end
end
