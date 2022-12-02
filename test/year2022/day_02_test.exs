defmodule AdventOfCode.Year2022.Day02Test do
  alias AdventOfCode.Year2022.Day02, as: Subject
  use ExUnit.Case

  describe "transform_line_pt_1/1" do
    test "succeeds" do
      assert Subject.transform_line_pt_1("A X") == {:rock, :rock}
      assert Subject.transform_line_pt_1("A Y") == {:rock, :paper}
      assert Subject.transform_line_pt_1("A Z") == {:rock, :scissors}
      assert Subject.transform_line_pt_1("B X") == {:paper, :rock}
      assert Subject.transform_line_pt_1("B Y") == {:paper, :paper}
      assert Subject.transform_line_pt_1("B Z") == {:paper, :scissors}
      assert Subject.transform_line_pt_1("C X") == {:scissors, :rock}
      assert Subject.transform_line_pt_1("C Y") == {:scissors, :paper}
      assert Subject.transform_line_pt_1("C Z") == {:scissors, :scissors}
    end
  end

  describe "points_for/1" do
    test "calculates" do
      # Draw + 1 point
      assert Subject.points_for({:rock, :rock}) == 4

      # Won + 2 points
      assert Subject.points_for({:rock, :paper}) == 8

      # Lost + 3 points
      assert Subject.points_for({:rock, :scissors}) == 3

      assert Subject.points_for({:paper, :rock}) == 1

      assert Subject.points_for({:paper, :paper}) == 5

      assert Subject.points_for({:paper, :scissors}) == 9

      assert Subject.points_for({:scissors, :rock}) == 7

      assert Subject.points_for({:scissors, :paper}) == 2

      assert Subject.points_for({:scissors, :scissors}) == 6
    end
  end

  describe "calc_part_1/1" do
    test "tallies" do
      input = [{:rock, :paper}, {:paper, :rock}, {:scissors, :scissors}]

      assert Subject.calc_part_1(input) == 15
    end
  end
end
