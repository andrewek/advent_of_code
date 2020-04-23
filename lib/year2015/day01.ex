defmodule AdventOfCode.Year2015.Day01 do
  def part_1(input) do
    input
    |> split()
    |> calc_floor()
  end

  defp split(input) do
    String.split(input, "", trim: true)
  end

  defp calc_floor(list, current_floor \\ 0)

  defp calc_floor([], current_floor) do
    current_floor
  end

  defp calc_floor(["(" | tail], current_floor) do
    calc_floor(tail, current_floor + 1)
  end

  defp calc_floor([")" | tail], current_floor) do
    calc_floor(tail, current_floor - 1)
  end
end
