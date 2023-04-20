#!/usr/bin/env ruby

# Read input from stdin
input = []
ARGF.each_line { |line| input << line.chomp }

def mark_island(row, col, input, visited)
  # Return early on invalid tiles
  return 0 unless input[row][col] == '^' && !visited[row][col]

  visited[row][col] = true # Mark the current tile as visited

  # Recursively mark all adjacent land tiles as visited
  area = 1
  # check adjacency on from the left entry of the array
  area += mark_island_if_valid(row - 1, col, input, visited)

  # check adjacency on from the right entry of the array
  area += mark_island_if_valid(row + 1, col, input, visited)

  # check adjacency on from the left entry of the ^ char
  area += mark_island_if_valid(row, col - 1, input, visited)

  # check adjacency on from the right entry of the ^ char
  area += mark_island_if_valid(row, col + 1, input, visited)
  area
end

# Returns the area of an island and marks the visited array accordingly when a position is valid
def mark_island_if_valid(row, col, input, visited)
  # Check if the position is valid
  return 0 unless row >= 0 && col >= 0 && row < input.length && col < input[0].length

  # Recursively mark all adjacent land tiles as visited
  mark_island(row, col, input, visited)
end

# Create a 2D array to keep track of which tiles have been visited
visited = Array.new(input.length) { Array.new(input[0].length, false) }

# Loop through all tiles and call mark_island on each unvisited land tile
max_area = 0

input.each_with_index do |row, i|
  row.chars.each_with_index do |_tile, j|
    area = mark_island(i, j, input, visited)
    max_area = area if area > max_area
  end
end

# Output the area of the largest island
puts max_area
exit 0
