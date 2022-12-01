defmodule AdventOfCode.Year2022.Day01 do
  @doc """
  Given a list of all snacks carried by elves (by calorie), determine:

  1. Which elf carries the most calories
  2. Total calories carried by "top 3" elves

  https://adventofcode.com/2022/day/1#part2
  """
  def full_part_1() do
    collect_input()
    |> calc_part_1()
  end

  def full_part_2() do
    collect_input()
    |> calc_part_2()
  end

  def collect_input() do
    AdventOfCode.InputHelper.input_for(2022, 1)
    |> String.split("\n\n")
    |> Enum.map(fn el ->
      el
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  # Figure out the max calories any one elf is carrying
  def calc_part_1(inputs) do
    inputs
    |> Enum.map(&Enum.sum/1)
    |> Enum.max()
  end

  # Find total calories carried by top 3 elves
  def calc_part_2(inputs) do
    inputs
    |> Enum.map(&Enum.sum/1)
    |> Enum.sort(fn a, b -> a >= b end)
    |> Enum.take(3)
    |> Enum.sum()
  end
end
