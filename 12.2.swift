// swift 12.2.swift
// heavily influenced by: https://github.com/mpbarlow/AdventOfCode2024

import Foundation

let map = try String(contentsOf: URL(fileURLWithPath: "input/12.txt"), encoding: .utf8)
    .split(separator: "\n")
    .map { $0.split(separator: "") }

let maxX = map[0].count - 1
let maxY = map.count - 1

struct Coordinate: Hashable {
    let x: Int
    let y: Int
}

enum EdgeTracking {
    case before, after, none
}

struct Plot {
    let label: String
    let positions: Set<Coordinate>
    
    var area: Int {
        positions.count
    }
    
    var perimeter: Int {
        positions.reduce(0) { carry, coord in
            carry + directions
                .filter { dir in !positions.contains(Coordinate(x: coord.x + dir.x, y: coord.y + dir.y)) }
                .count
        }
    }
    
    var sides: Int {
        let xs = positions.map { $0.x }
        
        let rangeX = xs.min()!...(xs.max()! + 1)
        
        let ys = positions.map { $0.y }
        let rangeY = ys.min()!...(ys.max()! + 1)
        
        var edges = 0
        
        var trackingEdge = EdgeTracking.none {
            willSet {
                if newValue != .none && newValue != trackingEdge {
                    edges += 1
                }
            }
        }
        
        for x in rangeX {
            for y in rangeY {
                let before = positions.contains(Coordinate(x: x - 1, y: y))
                let after = positions.contains(Coordinate(x: x, y: y))
                
                if before && !after {
                    trackingEdge = .before
                } else if !before && after {
                    trackingEdge = .after
                } else {
                    trackingEdge = .none
                }
            }
        }
        
        trackingEdge = .none
        
        for y in rangeY {
            for x in rangeX {
                let before = positions.contains(Coordinate(x: x, y: y - 1))
                let after = positions.contains(Coordinate(x: x, y: y))

                if before && !after {
                    trackingEdge = .before
                } else if !before && after {
                    trackingEdge = .after
                } else {
                    trackingEdge = .none
                }
            }
        }
        
        return edges
    }
}

let directions: [(x: Int, y: Int)] = [(1, 0), (0, 1), (-1, 0), (0, -1)]

func buildPlotList() -> [Plot] {
    var plots = [Plot]()
    var visitedPositions = Set<Coordinate>()

    for (y, line) in map.enumerated() {
        for (x, cell) in line.enumerated() {
            if visitedPositions.contains(Coordinate(x: x, y: y)) {
                continue
            }
            
            let plotPositions = explorePlot(x: x, y: y)
            visitedPositions = visitedPositions.union(plotPositions)
            
            plots.append(Plot(label: String(cell), positions: plotPositions))
        }
    }
    
    return plots
}

func explorePlot(x: Int, y: Int, visited: Set<Coordinate> = Set<Coordinate>()) -> Set<Coordinate> {
    var visited = visited
    visited.insert(Coordinate(x: x, y: y))

    for dir in directions {
        let nextX = x + dir.x
        let nextY = y + dir.y
        
        if nextX < 0 || nextX > maxX || nextY < 0 || nextY > maxY {
            continue
        }
        
        if visited.contains(Coordinate(x: nextX, y: nextY)) {
            continue
        }
        
        if map[nextY][nextX] != map[y][x] {
            continue
        }
        
        visited = visited.union(explorePlot(x: nextX, y: nextY, visited: visited))
    }
    
    return visited
}

func partTwo() -> Int {
    return buildPlotList().reduce(0) { carry, plot in
        carry + (plot.area * plot.sides)
    }
}

print(partTwo())