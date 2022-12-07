defmodule AdventOfCode.Year2020.Day01Test do
  alias AdventOfCode.Year2020.Day01, as: Subject
  use ExUnit.Case, async: true

  describe "calc_part_1/1" do
    test "finds the product with a small list" do
      inputs = [1721, 979, 366, 299, 675, 1456]

      # 1721 and 299 sum to 2020, so those are the things we want.

      result = Subject.calc_part_1(inputs)
      assert result == 1721 * 299
    end
  end

  describe "find_triplet/3" do
    test "finds a triplet" do
      inputs = [1721, 979, 366, 299, 675, 1456]

      result = Subject.find_triplet(inputs)
      assert result == {979, 366, 675}
    end
  end

  describe "calc_part_2/1" do
    test "does the thing" do
      inputs = [1721, 979, 366, 299, 675, 1456]

      # 1721 and 299 sum to 2020, so those are the things we want.

      result = Subject.calc_part_2(inputs)
      assert result == 979 * 366 * 675
    end
  end
end
