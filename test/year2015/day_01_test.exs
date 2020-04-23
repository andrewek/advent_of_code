defmodule AdventOfCode.Year2015.Day01Test do
  alias AdventOfCode.Year2015.Day01
  use ExUnit.Case, async: true

  describe "#part_1" do
    test "calculates with a positive floor" do
      input = "()("
      assert Day01.part_1(input) == 1
    end

    test "calculates with a negative floor" do
      input = "()))("
      assert Day01.part_1(input) == -1
    end

    test "calculates with a zero floor" do
      input = "()"
      assert Day01.part_1(input) == 0
    end

    test "calculates with an empty list" do
      input = ""
      assert Day01.part_1(input) == 0
    end
  end
end
