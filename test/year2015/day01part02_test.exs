defmodule AdventOfCode.Year2015.Day01Part02Test do
  alias AdventOfCode.Year2015.Day01Part02
  use ExUnit.Case, async: true

  describe "#calculate" do
    test "with an empty list returns length" do
      input = ""
      assert Day01Part02.calculate(input) == 0
    end

    test "with only positive floors returns length" do
      input = "(("
      assert Day01Part02.calculate(input) == 2
    end

    test "with a single negative floor returns that position" do
      input = ")"
      assert Day01Part02.calculate(input) == 1
    end

    test "with a more normal use case returns basement position" do
      input = "((()))())"
      assert Day01Part02.calculate(input) == 9
    end

    test "returns first basement excursion" do
      input = "(()))((())))"
      assert Day01Part02.calculate(input) == 5
    end
  end
end
