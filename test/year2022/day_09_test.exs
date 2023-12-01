defmodule AdventOfCode.Year2022.Day09Test do
  alias AdventOfCode.Year2022.Day09, as: Subject
  use ExUnit.Case, async: true

  @inputs """
  R 4
  U 4
  L 3
  D 1
  R 4
  D 1
  L 5
  R 2
  """

  setup do
    moves =
      @inputs
      |> String.split("\n", trim: true)
      |> Enum.map(&Subject.remap_input/1)

    state = Subject.build_initial_state(moves)
    part_2_state = Subject.build_initial_state_2(moves)

    %{moves: moves, state: state, part_2_state: part_2_state}
  end

  # describe "calc_part_1/1" do
  #   test "works" do
  #     assert 13 ==
  #              @inputs
  #              |> String.split("\n", trim: true)
  #              |> Subject.calc_part_1()
  #   end
  # end

  # describe "perform_moves/1" do
  #   test "with empty moves", %{state: state} do
  #     state =
  #       state
  #       |> Map.put(:moves, [])

  #     assert state == Subject.perform_moves(state)

  #     assert state.head == {0, 0}
  #     assert state.tail == {0, 0}
  #     assert state.tail_moves == MapSet.new([{0, 0}])
  #   end

  #   test "with part 2", %{part_2_state: state} do
  #     result = Subject.perform_moves(state, &Subject.perform_one_move_pt_2/1)

  #     assert result.head == {2, 2}
  #     assert result.knot_1 == {1, 2}
  #     assert result.knot_2 == {2, 2}
  #     assert result.knot_3 == {3, 2}
  #     assert result.knot_4 == {2, 2}
  #     assert result.knot_5 == {1, 1}
  #     assert result.knot_6 == {0, 0}
  #     assert result.knot_7 == {0, 0}
  #     assert result.knot_8 == {0, 0}
  #     assert result.tail == {0, 0}
  #   end

  #   test "with some spaces", %{state: state} do
  #     result =
  #       state
  #       |> Map.put(:moves, [{:right, 4}, {:up, 4}])
  #       |> Subject.perform_moves()

  #     assert result.head == {4, 4}
  #     assert result.tail == {4, 3}
  #     assert result.moves == []

  #     assert result.tail_moves ==
  #              MapSet.new([{0, 0}, {1, 0}, {2, 0}, {3, 0}, {4, 1}, {4, 2}, {4, 3}])
  #   end
  # end

  # describe "perform_one_move/1" do
  #   test "with no spaces", %{state: state} do
  #     state =
  #       state
  #       |> Map.put(:moves, [{:up, 0}])

  #     result = Subject.perform_one_move(state)

  #     assert result.head == {0, 0}
  #     assert result.tail == {0, 0}
  #     assert result.moves == []
  #     assert result.tail_moves == MapSet.new([{0, 0}])
  #   end

  #   test "with just one space", %{state: state} do
  #     state =
  #       state
  #       |> Map.put(:moves, [{:up, 1}])

  #     result = Subject.perform_one_move(state)

  #     assert result.head == {0, 1}
  #     assert result.tail == {0, 0}
  #     assert result.moves == [{:up, 0}]
  #     assert result.tail_moves == MapSet.new([{0, 0}])
  #   end

  #   test "with many spaces", %{state: state} do
  #     state =
  #       state
  #       |> Map.put(:moves, [{:up, 2}])

  #     result = Subject.perform_one_move(state)

  #     assert result.head == {0, 1}
  #     assert result.tail == {0, 0}
  #     assert result.moves == [{:up, 1}]
  #     assert result.tail_moves == MapSet.new([{0, 0}])
  #   end

  #   test "with different start position", %{state: state} do
  #     state =
  #       state
  #       |> Map.put(:moves, [{:up, 2}])
  #       |> Map.put(:head, {0, 1})

  #     result = Subject.perform_one_move(state)

  #     assert result.head == {0, 2}
  #     assert result.tail == {0, 1}
  #     assert result.moves == [{:up, 1}]
  #     assert result.tail_moves == MapSet.new([{0, 0}, {0, 1}])
  #   end
  # end

  # describe "move_head/2" do
  #   test "up" do
  #     assert {0, 1} = Subject.move_head({0, 0}, :up)
  #   end

  #   test "down" do
  #     assert {0, -1} = Subject.move_head({0, 0}, :down)
  #   end

  #   test "left" do
  #     assert {-1, 0} = Subject.move_head({0, 0}, :left)
  #   end

  #   test "right" do
  #     assert {1, 0} = Subject.move_head({0, 0}, :right)
  #   end
  # end

  # describe "next_tail_coords/2" do
  #   test "adjecent" do
  #     assert {0, 1} = Subject.next_tail_coords({0, 0}, {0, 1})
  #     assert {0, -1} = Subject.next_tail_coords({0, 0}, {0, -1})
  #     assert {1, 0} = Subject.next_tail_coords({0, 0}, {1, 0})
  #     assert {1, 1} = Subject.next_tail_coords({0, 0}, {1, 1})
  #     assert {1, -1} = Subject.next_tail_coords({0, 0}, {1, -1})
  #     assert {-1, -1} = Subject.next_tail_coords({0, 0}, {-1, -1})
  #     assert {-1, 0} = Subject.next_tail_coords({0, 0}, {-1, 0})
  #     assert {-1, 1} = Subject.next_tail_coords({0, 0}, {-1, 1})
  #   end

  #   test "two away - top" do
  #     assert {0, 1} = Subject.next_tail_coords({0, 2}, {0, 0})
  #   end

  #   test "two away - bottom" do
  #     assert {0, -1} = Subject.next_tail_coords({0, -2}, {0, 0})
  #   end

  #   test "two away - left" do
  #     assert {-1, 0} = Subject.next_tail_coords({-2, 0}, {0, 0})
  #   end

  #   test "two away - right" do
  #     assert {1, 0} = Subject.next_tail_coords({2, 0}, {0, 0})
  #   end

  #   test "two away - top-left" do
  #     assert {-1, 1} = Subject.next_tail_coords({-2, 2}, {0, 0})
  #   end

  #   test "two away - top-right" do
  #     assert {1, 1} = Subject.next_tail_coords({2, 2}, {0, 0})
  #   end

  #   test "two away - bottom left" do
  #     assert {-1, -1} = Subject.next_tail_coords({-2, -2}, {0, 0})
  #   end

  #   test "two away - bottom right" do
  #     assert {1, -1} = Subject.next_tail_coords({2, -2}, {0, 0})
  #   end

  #   test "two away - top-top-right" do
  #     assert {1, 0} = Subject.next_tail_coords({2, 0}, {0, 0})
  #     assert {2, 0} = Subject.next_tail_coords({3, 0}, {1, 0})
  #     assert {3, 0} = Subject.next_tail_coords({4, 0}, {2, 0})
  #     assert {3, 0} = Subject.next_tail_coords({4, 1}, {3, 0})
  #     assert {4, 1} = Subject.next_tail_coords({4, 2}, {3, 0})
  #     assert {4, 2} = Subject.next_tail_coords({4, 3}, {4, 1})
  #   end

  #   test "overlapped" do
  #     assert {0, 0} = Subject.next_tail_coords({0, 0}, {0, 0})
  #   end
  # end

  # describe "build_initial_state/1" do
  #   test "builds correctly", %{moves: moves} do
  #     result = Subject.build_initial_state(moves)

  #     assert result == %{
  #              head: {0, 0},
  #              tail: {0, 0},
  #              tail_moves: MapSet.new([{0, 0}]),
  #              moves: [
  #                {:right, 4},
  #                {:up, 4},
  #                {:left, 3},
  #                {:down, 1},
  #                {:right, 4},
  #                {:down, 1},
  #                {:left, 5},
  #                {:right, 2}
  #              ]
  #            }
  #   end
  # end

  # describe "remap_input/1" do
  #   test "remaps" do
  #     assert {:right, 93} = Subject.remap_input("R 93")
  #     assert {:up, 3} = Subject.remap_input("U 3")
  #     assert {:left, 3} = Subject.remap_input("L 3")
  #     assert {:down, 3} = Subject.remap_input("D 3")
  #   end
  # end
end
