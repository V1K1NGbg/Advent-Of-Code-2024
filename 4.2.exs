# elixir 4.2.exs

read = fn name ->
  File.read!(name)
  |> String.split("\n", trim: true)
end

found? = fn grid, row, col ->
  if row > 0 and row < length(grid) - 1 and col > 0 and col < String.length(Enum.at(grid, row)) - 1 do

    tl = String.at(Enum.at(grid, row - 1), col - 1)
    tr = String.at(Enum.at(grid, row - 1), col + 1)
    c = String.at(Enum.at(grid, row), col)
    bl = String.at(Enum.at(grid, row + 1), col - 1)
    br = String.at(Enum.at(grid, row + 1), col + 1)

    (tl == "M" and tr == "S" and c == "A" and bl == "M" and br == "S") or
    (tr == "M" and tl == "S" and c == "A" and br == "M" and bl == "S") or
    (tl == "M" and tr == "M" and c == "A" and bl == "S" and br == "S") or
    (tr == "S" and tl == "S" and c == "A" and br == "M" and bl == "M")
  else
    false
  end
end

count = fn grid ->
  Enum.reduce(1..(length(grid) - 2), 0, fn row, total ->
    Enum.reduce(1..(String.length(Enum.at(grid, row)) - 2), total, fn col, stotal ->
      if found?.(grid, row, col), do: stotal + 1, else: stotal
    end)
  end)
end

name = "input/4.txt"
grid = read.(name)

IO.puts count.(grid)
