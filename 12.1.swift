// swift 12.1.swift

import Foundation

let fileURL = URL(fileURLWithPath: "input/12.txt")
let map: [String]
do {
    let content = try String(contentsOf: fileURL, encoding: .utf8)
    map = content.components(separatedBy: .newlines).filter { !$0.isEmpty }
} catch {
    fatalError("Failed to read file: \(error)")
}

let rows = map.count
let cols = map[0].count
var visited = Array(repeating: Array(repeating: false, count: cols), count: rows)
let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
var totalCost = 0

func dfs(_ row: Int, _ col: Int, _ plantType: Character) -> (area: Int, perimeter: Int) {
    var stack = [(row, col)]
    var area = 0
    var perimeter = 0

    while !stack.isEmpty {
        let (r, c) = stack.removeLast()
        if visited[r][c] {
            continue
        }
        visited[r][c] = true
        area += 1

        for (dr, dc) in directions {
            let nr = r + dr
            let nc = c + dc
            if nr >= 0 && nr < rows && nc >= 0 && nc < cols {
                if map[nr][map[nr].index(map[nr].startIndex, offsetBy: nc)] == plantType {
                    if !visited[nr][nc] {
                        stack.append((nr, nc))
                    }
                } else {
                    perimeter += 1
                }
            } else {
                perimeter += 1
            }
        }
    }

    return (area, perimeter)
}

for r in 0..<rows {
    for c in 0..<cols {
        if !visited[r][c] {
            let plantType = map[r][map[r].index(map[r].startIndex, offsetBy: c)]
            let (area, perimeter) = dfs(r, c, plantType)
            totalCost += area * perimeter
        }
    }
}

print(totalCost)
