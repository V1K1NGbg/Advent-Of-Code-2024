# elixir 4.1.exs

word = "XMAS"

read = fn name ->
  File.read!(name)
  |> String.split("\n", trim: true)
end

found? = fn grid, row, col, dx, dy, word ->
  Enum.all?(0..(String.length(word) - 1), fn i ->
    nrow = row + i * dx
    ncol = col + i * dy

    nrow >= 0 and nrow < length(grid) and
      ncol >= 0 and ncol < String.length(Enum.at(grid, nrow)) and
      String.at(Enum.at(grid, nrow), ncol) == String.at(word, i)
  end)
end

dir = [
  {0, 1},
  {1, 0},
  {0, -1},
  {-1, 0},

  {1, 1},
  {1, -1},
  {-1, 1},
  {-1, -1}
]

count = fn grid, word ->
  Enum.reduce(0..(length(grid) - 1), 0, fn row, total ->
    Enum.reduce(0..(String.length(Enum.at(grid, row)) - 1), total, fn col, stotal ->
      Enum.reduce(dir, stotal, fn {dx, dy}, count ->
        if found?.(grid, row, col, dx, dy, word), do: count + 1, else: count
      end)
    end)
  end)
end

name = "input/4.txt"
grid = read.(name)

IO.puts count.(grid, word)
