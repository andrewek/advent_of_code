# Advent of Code

Solutions for Advent Of Code 2015-now, organized by year and day.

## Installation

1. Clone the repository
2. `$ mix deps.get`
3. `$ mix test`

To play with the code in IEX:

```sh
$ iex -S mix
```

## Puzzle Inputs

All puzzle inputs are stored in `puzzle_inputs/yyyy/day_dd.txt` (e.g.
`puzzle_inputs/2015/day_01.txt`.

You can access them in IEX like so:

```elixir
AdventOfCode.PuzzleInput.input_for(2015, 1)
```

Which will look for a file called `puzzle_inputs/2015/day_01.txt`, read it, and
open it. The resultant file will be a single string. You'll have to do further
work to get that string into the format you want.
