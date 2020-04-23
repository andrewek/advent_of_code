defmodule AdventOfCode.Year2015.Day01Part02 do
  def calculate(input) do
    input
    |> split()
    |> calc_basement()
  end

  defp split(input) do
    String.split(input, "", trim: true)
  end

  defp calc_basement(list, current_floor \\ 0, count \\ 0)

  defp calc_basement(_list, current_floor, count) when current_floor < 0 do
    count
  end

  defp calc_basement(["(" | tail], current_floor, count) do
    calc_basement(tail, current_floor + 1, count + 1)
  end

  defp calc_basement([")" | tail], current_floor, count) do
    calc_basement(tail, current_floor - 1, count + 1)
  end

  defp calc_basement([], _current_floor, count) do
    count
  end
end
