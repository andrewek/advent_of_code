defmodule AdventOfCode.Year2021.Day02 do
  @moduledoc """
  https://adventofcode.com/2021/day/2
  """

  @doc """
  Given {horizontal: 0, depth: 0} and a set of instructions, do some
  determinations
  """
  def part_01(inputs) do
    inputs
    |> Enum.reduce(%{horizontal: 0, depth: 0}, fn step, accumulator ->
      new_coord(accumulator, step)
    end)
  end

  def new_coord(%{horizontal: h, depth: d}, {:down, amt}) do
    %{horizontal: h, depth: d + amt}
  end

  def new_coord(%{horizontal: h, depth: d}, {:up, amt}) do
    %{horizontal: h, depth: d - amt}
  end

  def new_coord(%{horizontal: h, depth: d}, {:forward, amt}) do
    %{horizontal: h + amt, depth: d}
  end

  @doc """
  down X increases your aim by X units.
  up X decreases your aim by X units.
  forward X does two things:
    It increases your horizontal position by X units.
    It increases your depth by your aim multiplied by X.
  """
  def part_02(inputs) do
    inputs
    |> Enum.reduce(%{horizontal: 0, depth: 0, aim: 0}, fn step, coords ->
      new_aim(coords, step)
    end)
  end

  def new_aim(%{horizontal: h, depth: d, aim: a}, {:down, amt}) do
    %{
      horizontal: h,
      depth: d,
      aim: a + amt
    }
  end

  def new_aim(%{horizontal: h, depth: d, aim: a}, {:up, amt}) do
    %{
      horizontal: h,
      depth: d,
      aim: a - amt
    }
  end

  def new_aim(%{horizontal: h, depth: d, aim: a}, {:forward, amt}) do
    %{
      horizontal: h + amt,
      depth: d + a * amt,
      aim: a
    }
  end

  def collect_input() do
    AdventOfCode.InputHelper.input_for(2021, 2)
    |> String.split("\n")
    |> Enum.map(fn el ->
      [dir, amt] = String.split(el, " ")

      {
        String.to_atom(dir),
        String.to_integer(amt)
      }
    end)
  end
end
