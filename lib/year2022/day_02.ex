defmodule AdventOfCode.Year2022.Day02 do
  @moduledoc """
  Do some rock-paper-scissor scoring

  https://adventofcode.com/2022/day/2
  """

  @doc """
  Given [{:rock, :paper} ...], calculate final score

  6 points for winning a game
  3 points for draw
  0 points for losing

  1 point for playing rock
  2 for playing paper
  3 for playing scissors

  In a given move tuple {:rock, :paper} the first opponent's move, the second is your move
  """
  def calc_part_1(inputs) do
    inputs
    |> Enum.map(&points_for/1)
    |> Enum.sum()
  end

  @doc """

  """
  def calc_part_2(inputs) do
    inputs
    |> Enum.map(&points_for/1)
    |> Enum.sum()
  end

  def collect_input() do
    AdventOfCode.InputHelper.input_for(2022, 2)
    |> String.split("\n", trim: true)
  end

  def full_part_1() do
    collect_input()
    |> Enum.map(&transform_line_pt_1/1)
    |> calc_part_1()
  end

  def full_part_2() do
    collect_input()
    |> Enum.map(&transform_line_pt_2/1)
    |> calc_part_2()
  end

  def points_for({:rock, :rock}), do: 4
  def points_for({:rock, :paper}), do: 8
  def points_for({:rock, :scissors}), do: 3
  def points_for({:paper, :rock}), do: 1
  def points_for({:paper, :paper}), do: 5
  def points_for({:paper, :scissors}), do: 9
  def points_for({:scissors, :rock}), do: 7
  def points_for({:scissors, :paper}), do: 2
  def points_for({:scissors, :scissors}), do: 6

  @doc """
  "A X" -> {:rock, :rock}

  A and X -> Rock
  B and Y -> Paper
  C and Z -> Scissors
  """
  def transform_line_pt_1(line) do
    line
    |> String.split(" ", trim: true)
    |> Enum.map(&move_for_pt_1/1)
    |> List.to_tuple()
  end

  @doc """
  A -> Rock, B -> Paper, C -> Scissors

  X -> desired loss
  Y -> desired tie
  Z -> desired win

  Takes "A Z" or something like that, returns move tuple satisfying outcome
  """
  def transform_line_pt_2(line) do
    case line do
      "A X" -> {:rock, :scissors}
      "A Y" -> {:rock, :rock}
      "A Z" -> {:rock, :paper}
      "B X" -> {:paper, :rock}
      "B Y" -> {:paper, :paper}
      "B Z" -> {:paper, :scissors}
      "C X" -> {:scissors, :paper}
      "C Y" -> {:scissors, :scissors}
      "C Z" -> {:scissors, :rock}
    end
  end

  defp move_for_pt_1(char) when char == "A" or char == "X" do
    :rock
  end

  defp move_for_pt_1(char) when char == "B" or char == "Y" do
    :paper
  end

  defp move_for_pt_1(char) when char == "C" or char == "Z" do
    :scissors
  end
end
