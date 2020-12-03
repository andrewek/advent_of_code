defmodule AdventOfCode.Year2020.Day01 do
  @doc """
  Given an array of numbers, find the two that sum to 2020, then multiply.
  Return their product
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
    AdventOfCode.InputHelper.input_for(2020, 1)
    |> String.split("\n")
    |> Enum.map(fn(el) -> String.to_integer(el) end)
  end

  def calc_part_1(inputs) do
    {a, b} = find_pair(inputs)
    a * b
  end

  def calc_part_2(inputs) do
    {a, b, c} =
      find_triplet(inputs)
      |> IO.inspect()

    a * b * c
  end

  # Get the party started
  def find_triplet(inputs) do
    head = hd(inputs)
    tail = tl(inputs)

    desired = 2020 - head

    found = find_pair(tail, desired)

    case found do
      :error -> find_triplet(tail)
      {a, b} ->
        {head, a, b}
    end
  end

  def find_pair(inputs, desired_sum \\ 2020)

  def find_pair([], _) do
    :error
  end

  # Part 1 - find a matching pair for 2020, return as a tuple of two elements
  def find_pair(inputs, desired_sum) do
    head = hd(inputs)
    tail = tl(inputs)

    found = Enum.find(tail, fn(e) -> head + e == desired_sum end)

    case found do
      nil -> find_pair(tail, desired_sum)
      val -> {head, val}
    end
  end
end
