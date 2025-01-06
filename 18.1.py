# python3 18.1.py

from collections import deque

input = open('input/18.txt').read()

def parse(input):
    coordinates = []
    for line in input.strip().split("\n"):
        x, y = map(int, line.split(","))
        coordinates.append((x, y))
    return coordinates

def add_point(grid_size, coordinates, max_bytes):
    grid = [[0 for _ in range(grid_size)] for _ in range(grid_size)]
    for i, (x, y) in enumerate(coordinates):
        if i >= max_bytes:
            break
        grid[y][x] = 1
    return grid

def bfs(grid, start, end):
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    queue = deque([(start, 0, [start])])
    visited = set([start])

    while queue:
        (x, y), steps, path = queue.popleft()

        if (x, y) == end:
            return steps, path + [(x, y)]

        for dx, dy in directions:
            nx, ny = x + dx, y + dy
            if 0 <= nx < len(grid) and 0 <= ny < len(grid) and (nx, ny) not in visited and grid[ny][nx] == 0:
                visited.add((nx, ny))
                queue.append(((nx, ny), steps + 1, path + [(nx, ny)]))

    return -1, []

def print_grid(grid, path):
    for y, row in enumerate(grid):
        for x, cell in enumerate(row):
            if (x, y) in path:
                print("o", end="")
            elif cell == 1:
                print("#", end="")
            else:
                print(".", end="")
        print()

### Part 1
size = 71
start = (0, 0)
end = (size - 1, size - 1)

coordinates = parse(input)
grid = add_point(size, coordinates, 1024)
length, path = bfs(grid, start, end)
print(length)