defmodule AdventOfCode.Year2021.Day03 do
  @moduledoc """
  https://adventofcode.com/2021/day/3
  """

  def part_01(inputs) do
    gamma_digits=
      inputs
      |> Enum.zip_reduce([], fn(elements, acc) -> [elements | acc] end)
      |> Enum.reverse()
      |> Enum.map(&Enum.sum(&1))
      |> Enum.map(fn(el) -> el / length(inputs) |> round() end)

    epsilon_digits =
      gamma_digits
      |> Enum.map(fn(d) -> abs(d - 1) end)

    gamma_binary = Enum.join(gamma_digits)
    epsilon_binary = Enum.join(epsilon_digits)

    %{
      gamma_binary: gamma_binary,
      epsilon_binary: epsilon_binary,
      gamma: String.to_integer(gamma_binary, 2),
      epsilon: String.to_integer(epsilon_binary, 2)
    }
  end

  ############# PART 2 ########################################

  def part_02(inputs) do
    o2_scrubber = most_common_bits(inputs)
    co2_scrubber = least_common_bits(inputs)

    %{
      o2: o2_scrubber,
      co2: co2_scrubber,
      product: o2_scrubber * co2_scrubber
    }
  end

  def most_common_bits(inputs, position \\ 0)

  def most_common_bits(inputs, _position) when length(inputs) == 1 do
    hd(inputs) |> Enum.join("") |> String.to_integer(2)
  end

  def most_common_bits(inputs, position) do
    desired_bit =
      inputs
      |> frequencies(position)
      |> most_common()

    filtered =
      inputs
      |> Enum.filter(fn(i) -> desired_bit == Enum.at(i, position) end)

    most_common_bits(filtered, position + 1)
  end

  def least_common_bits(inputs, position \\ 0)

  def least_common_bits(inputs, _position) when length(inputs) == 1 do
    hd(inputs) |> Enum.join("") |> String.to_integer(2)
  end

  def least_common_bits(inputs, position) do
    desired_bit =
      inputs
      |> frequencies(position)
      |> least_common()

    filtered =
      inputs
      |> Enum.filter(fn(i) -> desired_bit == Enum.at(i, position) end)

    least_common_bits(filtered, position + 1)
  end

  def frequencies(inputs, position) do
    inputs
    |> Enum.map(fn(el) -> Enum.at(el, position) end)
    |> Enum.frequencies()
  end

  def most_common(%{0 => zeros, 1 => ones}) do
    if ones >= zeros do
      1
    else
      0
    end
  end

  def least_common(%{0 => zeros, 1 => ones}) do
    if zeros <= ones do
      0
    else
      1
    end
  end

  ############# INPUT COLLECTION ###############################

  def collect_input() do
    AdventOfCode.InputHelper.input_for(2021, 3)
    |> String.split("\n", trim: true)
    |> Enum.map(fn(el) -> split_and_cast(el) end)
  end

  def split_and_cast(str) do
    str
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end
end

