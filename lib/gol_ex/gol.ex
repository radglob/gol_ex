defmodule GameOfLife do

  defstruct width: 10, height: 10, grid: %{}

  @live "@"
  @dead "-"

  def new(attrs \\ []) do
    __MODULE__.__struct__(attrs)
  end

  defp fetch(board, x, y) do
    Map.get(board.grid, {x, y}, @dead)
  end

  def new_random(height, width) do
    grid = 
      for x <- (1..width),
          y <- (1..height) do
            cell = 
              [@live, @dead]
              |> Enum.shuffle()
              |> hd()
            {{x, y}, cell}
      end
      |> Map.new()
    new(height: height, width: width, grid: grid)
  end

  def print(board) do
    for row <- (1..board.height) do
      row_to_string(board, row)
    end
    |> Enum.join("\n")
    |> IO.puts()
  end

  defp row_to_string(board, y) do
    for x <- (1..board.width) do
      fetch(board, x, y)
    end
    |> Enum.join("")
  end

  defp neighbors(board, x, y) do
    [
      {x-1, y-1}, {x, y-1}, {x+1, y-1},
      {x-1, y},             {x+1, y},
      {x+1, y+1}, {x, y+1}, {x+1, y+1}
    ]
    |> Enum.map(fn {x_, y_} -> fetch(board, x_, y_) end)
    |> Enum.filter(&(&1 == @live))
    |> Enum.count()
  end

  defp rule(n, _cell) when n <= 2, do: @dead
  defp rule(n, _cell) when n > 3, do: @dead
  defp rule(n, _cell) when n == 3, do: @live
  defp rule(_n, cell), do: cell

  def next_generation(board) do
    grid = 
      for x <- (1..board.width),
          y <- (1..board.height) do
        {{x, y}, rule(neighbors(board, x, y), fetch(board, x, y))}
      end
      |> Map.new

    new(height: board.height, width: board.width, grid: grid)
  end
end
