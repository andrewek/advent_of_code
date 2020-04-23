defmodule AdventOfCode.Year2015.Day02Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Year2015.Day02

  describe "#calculate_paper/1" do
    test "calculates correctly with one input" do
      input = "2x3x4"
      assert Day02.calculate_paper(input) == 58
    end

    test "calculates correctly with two inputs" do
      input = "2x3x4\n1x1x10"
      assert Day02.calculate_paper(input) == (58 + 43)
    end
  end

  describe "#calculate_ribbon/1" do
    test"calculates for one box" do
      input = "2x3x4"
      assert Day02.calculate_ribbon(input) == 34
    end

    test "calculates for two boxes" do
      input = "2x3x4\n1x1x10"
      assert Day02.calculate_ribbon(input) == (34 + 14)
    end
  end
end
