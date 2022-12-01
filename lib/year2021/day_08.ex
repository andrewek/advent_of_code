defmodule AdventOfCode.Year2021.Day08 do
  @moduledoc """
  https://adventofcode.com/2021/day/8

  0 - abcefg (6)
  1 - cf (2)
  2 - acdeg (5)
  3 - acdfg (5)
  4 - bdcf (4)
  5 - abdfg (5)
  6 - abdefg (6)
  7 - acf (3)
  8 - abcdefg (7)
  9 - abcdfg (6)
  """

  # Count 1, 4, 7, 8 in outputs by length
  def part_1(inputs) do
    counts =
      inputs
      |> Enum.map(fn i -> i.outputs end)
      |> Enum.map(&count_digits/1)

    counts
    |> Enum.map(fn m -> Enum.reduce(m, 0, fn {_k, v}, acc -> acc + v end) end)
    |> Enum.sum()
  end

  def count_digits(row) do
    %{
      1 => Enum.count(row, fn el -> String.length(el) == 2 end),
      4 => Enum.count(row, fn el -> String.length(el) == 4 end),
      7 => Enum.count(row, fn el -> String.length(el) == 3 end),
      8 => Enum.count(row, fn el -> String.length(el) == 7 end)
    }
  end

  ################## PART 2 #####################################

  @doc """
  For each row, determine the mapping.

  Each row has only one mapping that makes sense. For example:

  BAD  dddd       GOOD  aaaa
      e    a           b    c
      e    a           b    c
       ffff    ----->   dddd
      g    b           e    f
      g    b           e    f
       cccc             gggg

    BAD    GOOD
    d   ->    a
    e   ->    b
    a   ->    c
    f   ->    d
    g   ->    e
    b   ->    f
    c   ->    g

    cefdb -> gbdaf -> abdfg -> 5

    We know 1, 4, 7, and 8 based on length of strings.

    0 - abcefg (6) -- excludes d
    1 - cf (2) ------ excludes abdeg
    2 - acdeg (5) --- excludes bf
    3 - acdfg (5) --- excludes be
    4 - bcdf (4) ---- excludes aeg
    5 - abdfg (5) --- excludes ce
    6 - abdefg (6) -- excludes c
    7 - acf (3) ----- excludes bdeg
    8 - abcdefg (7) - excludes  -
    9 - abcdfg (6)  - excludes e

    INCLUDES
    a - 0, 2, 3, 5, 6, 7, 8, 9
    b - 0, 4, 5, 6, 8, 9
    c - 0, 1, 2, 3, 4, 7, 8, 9
    d - 2, 3, 4, 5, 6, 8, 9
    e - 0, 2, 4, 6, 8, 9
    f - 0, 1, 3, 4, 5, 6, 7, 8, 9
    g - 0, 2, 3, 5, 6, 8, 9

    EXCLUDES
    a - 1, 4
    b - 1, 2, 3, 7
    c - 5, 6
    d - 0, 1, 7
    e - 1, 3, 5, 7
    f - 2
    g - 1, 4, 7
  """
  def solve_row(%{inputs: _inputs, outputs: outputs} = input_row) do
    key = build_key(input_row)

    outputs
    |> Enum.map(fn str ->
      String.split(str, "", trim: true) |> Enum.map(&String.to_atom/1) |> Enum.sort()
    end)
    |> Enum.map(fn chrs -> convert_digit(chrs, key) end)
    |> Enum.join()
    |> String.to_integer()
  end

  def convert_digit(chars, key) do
    chars
    |> Enum.map(fn c -> Map.get(key, c) end)
    |> Enum.sort()
    |> case do
      [:a, :b, :c, :e, :f, :g] -> 0
      [:c, :f] -> 1
      [:a, :c, :d, :e, :g] -> 2
      [:a, :c, :d, :f, :g] -> 3
      [:b, :c, :d, :f] -> 4
      [:a, :b, :d, :f, :g] -> 5
      [:a, :b, :d, :e, :f, :g] -> 6
      [:a, :c, :f] -> 7
      [:a, :b, :c, :d, :e, :f, :g] -> 8
      [:a, :b, :c, :d, :f, :g] -> 9
    end
  end

  def build_key(%{inputs: inputs, outputs: outputs}) do
    # Get 1-10 from puzzle input, then de-dupe
    all_vals =
      (inputs ++ outputs)
      |> Enum.map(fn str ->
        String.split(str, "", trim: true) |> Enum.map(&String.to_atom/1) |> Enum.sort()
      end)
      |> Enum.uniq()

    frequencies =
      all_vals
      |> List.flatten()
      |> Enum.frequencies()

    # Get F
    {f, _} = Enum.find(frequencies, fn {_k, v} -> v == 9 end)

    # 1 -> cf - use to get C
    [c] =
      all_vals
      |> Enum.find(fn v -> length(v) == 2 end)
      |> Enum.reject(fn v -> v == f end)

    # Use CF to get A
    [a] = Enum.find(all_vals, fn v -> length(v) == 3 end) -- [c, f]

    # 2 - ACDEG, 3 - ACDFG, and 5, ABDFG can be combined w/ ACF to solve for B
    # and E

    fives = Enum.filter(all_vals, fn a -> length(a) == 5 end)

    three = Enum.find(fives, fn v -> a in v and c in v and f in v end)
    two = Enum.find(fives, fn v -> a in v and c in v and f not in v end)
    five = Enum.find(fives, fn v -> a in v and c not in v and f in v end)

    [e] = two -- three
    [b] = five -- three

    # AS OF HERE WE HAVE:
    # A, B, C, E, F

    sixes = Enum.filter(all_vals, fn v -> length(v) == 6 end)
    # Solve for G w/ 0 --> ABCEFG
    zero =
      Enum.find(sixes, fn v ->
        a in v and b in v and c in v and e in v and f in v
      end)

    [g] = zero -- [a, b, c, e, f]

    # Now solve for D
    [d] = two -- [a, c, e, g]

    # Now solve for B
    [b] = five -- [a, d, f, g]

    %{
      a => :a,
      b => :b,
      c => :c,
      d => :d,
      e => :e,
      f => :f,
      g => :g
    }
  end

  ################## COLLECT INPUTS #############################

  def collect_inputs() do
    AdventOfCode.InputHelper.input_for(2021, 8)
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " | "))
    |> Enum.map(fn [inputs, outputs] ->
      %{
        inputs: process_string(inputs),
        outputs: process_string(outputs)
      }
    end)
  end

  def process_string(str) do
    str
    |> String.split(" ", trim: true)
    |> Enum.map(fn s -> String.split(s, "", trim: true) |> Enum.sort() |> Enum.join("") end)
  end
end
