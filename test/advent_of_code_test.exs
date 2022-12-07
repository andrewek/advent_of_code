defmodule AdventOfCodeTest do
  use ExUnit.Case, async: true
  doctest AdventOfCode

  test "greets the world" do
    assert AdventOfCode.hello() == :world
  end
end
