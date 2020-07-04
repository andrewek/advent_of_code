defmodule AdventOfCode.Year2015.Day16Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Year2015.Day16

  # akitas: 0
  # cars: 2
  # cats: 7
  # children: 3
  # goldfish: 5
  # perfumes: 1
  # pomeranians: 3
  # samoyeds: 2
  # trees: 3
  # vizslas: 0

  describe "reduce_lines/1" do
    test "with a few lines" do
      input = "Sue 1: cars: 9, akitas: 3, goldfish: 4\nSue 2: children: 3, pomeranians: 2, trees: 7"
      expected = [
        %{
          id: 1,
          akitas: 3,
          cars: 9,
          cats: nil,
          children: nil,
          goldfish: 4,
          perfumes: nil,
          pomeranians: nil,
          samoyeds: nil,
          trees: nil,
          vizslas: nil
        },
        %{
          id: 2,
          akitas: nil,
          cars: nil,
          cats: nil,
          children: 3,
          goldfish: nil,
          perfumes: nil,
          pomeranians: 2,
          samoyeds: nil,
          trees: 7,
          vizslas: nil
        }
      ]

      assert expected == Day16.reduce_lines(input)
    end
  end

  describe "reduce_line/1" do
    test "with one line" do
      input = "Sue 1: cars: 9, akitas: 3, goldfish: 4"
      expected = %{
        id: 1,
        akitas: 3,
        cars: 9,
        cats: nil,
        children: nil,
        goldfish: 4,
        perfumes: nil,
        pomeranians: nil,
        samoyeds: nil,
        trees: nil,
        vizslas: nil
      }

      assert expected == Day16.reduce_line(input)
    end
  end
end
