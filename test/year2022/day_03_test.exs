defmodule AdventOfCode.Year2022.Day03Test do
  alias AdventOfCode.Year2022.Day03, as: Subject
  use ExUnit.Case, async: true

  @inputs [
    "vJrwpWtwJgWrhcsFMMfFFhFp",
    "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
    "PmmdzqPrVvPwwTWBwg",
    "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
    "ttgJtRGJQctTZtZT",
    "CrZsJsPPZsGzwwsLwLmpwMDw"
  ]

  describe "calc_part_1/1" do
    test "with one input" do
      inputs = Enum.take(@inputs, 1)

      assert Subject.calc_part_1(inputs) == 16
    end

    test "with many inputs" do
      assert Subject.calc_part_1(@inputs) == 157
    end
  end

  describe "calc_part_2/1" do
    test "with inputs" do
      assert Subject.calc_part_2(@inputs) == 70
    end
  end
end
