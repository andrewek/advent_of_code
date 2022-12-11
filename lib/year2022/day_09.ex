defmodule AdventOfCode.Year2022.Day09 do
  @doc """
  https://adventofcode.com/2022/day/9
  """

  def collect_input() do
    AdventOfCode.InputHelper.input_for(2022, 9)
    |> String.split("\n")
  end

  # How many unique squares does the tail visit?
  def calc_part_1(inputs) do
    inputs
    |> Enum.map(&remap_input/1)
    |> build_initial_state()
    |> perform_moves()
    |> then(fn state -> Enum.count(state.tail_moves) end)
  end

  # Find total calories carried by top 3 elves
  def calc_part_2(inputs) do
    inputs
    |> Enum.map(&remap_input/1)
    |> build_initial_state_2()
    |> perform_moves(&perform_one_move_pt_2/1)
    |> then(fn state -> Enum.count(state.tail_moves) end)
  end

  ############# Process a move #####################

  @doc """
  Perform many moves
  """
  def perform_moves(state, perform_move_fn \\ &perform_moves/1)

  def perform_moves(%{moves: []} = state, _perform_move_fn) do
    state
  end

  def perform_moves(state, perform_move_fn) do
    new_state = perform_move_fn.(state)

    perform_moves(new_state, perform_move_fn)
  end

  @doc """
  Perform a single move, one space
  """
  def perform_one_move(%{moves: [{_dir, 0} | rest]} = state) do
    state
    |> Map.put(:moves, rest)
  end

  def perform_one_move(%{
        moves: [{dir, count} | rest],
        head: head,
        tail: tail,
        tail_moves: tail_moves
      }) do
    new_head = move_head(head, dir)
    new_tail = next_tail_coords(new_head, tail)
    new_tail_moves = MapSet.put(tail_moves, new_tail)
    new_moves = [{dir, count - 1} | rest]

    %{
      head: new_head,
      tail: new_tail,
      tail_moves: new_tail_moves,
      moves: new_moves
    }
  end

  def perform_one_move_pt_2(%{moves: [{_dir, 0} | rest]} = state) do
    state
    |> Map.put(:moves, rest)
  end

  def perform_one_move_pt_2(%{moves: [{dir, count} | rest]} = state) do
    new_head = move_head(state.head, dir)
    new_knot_1 = next_tail_coords(new_head, state.knot_1)
    new_knot_2 = next_tail_coords(new_knot_1, state.knot_2)
    new_knot_3 = next_tail_coords(new_knot_2, state.knot_3)
    new_knot_4 = next_tail_coords(new_knot_3, state.knot_4)
    new_knot_5 = next_tail_coords(new_knot_4, state.knot_5)
    new_knot_6 = next_tail_coords(new_knot_5, state.knot_6)
    new_knot_7 = next_tail_coords(new_knot_6, state.knot_7)
    new_knot_8 = next_tail_coords(new_knot_7, state.knot_8)
    new_tail = next_tail_coords(new_knot_8, state.tail)

    new_tail_moves = MapSet.put(state.tail_moves, new_tail)
    new_moves = [{dir, count - 1} | rest]

    %{
      head: new_head,
      knot_1: new_knot_1,
      knot_2: new_knot_2,
      knot_3: new_knot_3,
      knot_4: new_knot_4,
      knot_5: new_knot_5,
      knot_6: new_knot_6,
      knot_7: new_knot_7,
      knot_8: new_knot_8,
      tail: new_tail,
      tail_moves: new_tail_moves,
      moves: new_moves
    }
  end

  @doc """
  Given position and direction, move head one space
  """
  def move_head({x, y}, direction) do
    case direction do
      :up -> {x, y + 1}
      :down -> {x, y - 1}
      :left -> {x - 1, y}
      :right -> {x + 1, y}
    end
  end

  @doc """
  Given current head/tail position, calculate new tail position

  When tail is adjacent to head, it does not change. When it is two away in any
  direction, it moves 1 in that direction. It should never be more than 2 away.
  """
  # Head and tail on top of each other
  def next_tail_coords(head, tail) when head == tail do
    tail
  end

  # Same column, different row
  def next_tail_coords({head_x, head_y}, {tail_x, tail_y})
      when head_x == tail_x and head_y != tail_y do
    cond do
      # Head and tail are adjacent
      abs(head_y - tail_y) == 1 ->
        {tail_x, tail_y}

      # Not adjacent
      true ->
        y_offset = div(head_y - tail_y, 2)
        {tail_x, tail_y + y_offset}
    end
  end

  # Same row, different column
  def next_tail_coords({head_x, head_y}, {tail_x, tail_y})
      when head_y == tail_y and head_x != tail_x do
    cond do
      # Head and tail are adjacent
      abs(head_x - tail_x) == 1 ->
        {tail_x, tail_y}

      # Not adjacent
      true ->
        x_offset = div(head_x - tail_x, 2)
        {tail_x + x_offset, tail_y}
    end
  end

  def next_tail_coords({head_x, head_y}, {tail_x, tail_y}) do
    delta_x = head_x - tail_x
    delta_y = head_y - tail_y

    cond do
      abs(delta_x) == 1 && abs(delta_y) == 1 ->
        {tail_x, tail_y}

      true ->
        x_offset = div(abs(delta_x), delta_x)
        y_offset = div(abs(delta_y), delta_y)

        {tail_x + x_offset, tail_y + y_offset}
    end
  end

  ############# Input normalization ################

  def build_initial_state(moves) do
    %{
      head: {0, 0},
      tail: {0, 0},
      moves: moves,
      tail_moves: MapSet.new([{0, 0}])
    }
  end

  def build_initial_state_2(moves) do
    %{
      head: {0, 0},
      knot_1: {0, 0},
      knot_2: {0, 0},
      knot_3: {0, 0},
      knot_4: {0, 0},
      knot_5: {0, 0},
      knot_6: {0, 0},
      knot_7: {0, 0},
      knot_8: {0, 0},
      tail: {0, 0},
      moves: moves,
      tail_moves: MapSet.new([{0, 0}])
    }
  end

  # Turn something like "R 4" into {:right, 4}
  def remap_input(str) do
    [dir, count_str] = String.split(str)

    direction =
      case dir do
        "R" -> :right
        "U" -> :up
        "L" -> :left
        "D" -> :down
      end

    count = String.to_integer(count_str)

    {direction, count}
  end
end
