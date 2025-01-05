// kotlinc 14.1.kt -include-runtime -d 14.1.jar
// java -jar 14.1.jar

import java.io.File
import kotlin.math.abs

data class Point(val x: Int, val y: Int)
data class Robot(var position: Point, val velocity: Point)

fun main() {
    val input = File("input/14.txt").readLines()
    val width = 101
    val height = 103
    val robots = parseRobots(input)
    
    var seconds = 0
    while (true) {
        moveRobots(robots, width, height)
        seconds++
        
        if (detectPattern(robots, width, height)) {
            println(seconds)
            break
        }
    }
}

fun parseRobots(input: List<String>): List<Robot> {
    return input.map { line ->
        val (pos, vel) = line.split(" v=")
        val (px, py) = pos.removePrefix("p=").split(",").map { it.toInt() }
        val (vx, vy) = vel.split(",").map { it.toInt() }
        Robot(Point(px, py), Point(vx, vy))
    }
}

fun moveRobots(robots: List<Robot>, width: Int, height: Int) {
    robots.forEach { robot ->
        var newX = (robot.position.x + robot.velocity.x) % width
        var newY = (robot.position.y + robot.velocity.y) % height
        
        if (newX < 0) newX += width
        if (newY < 0) newY += height
        
        robot.position = Point(newX, newY)
    }
}

fun detectPattern(robots: List<Robot>, width: Int, height: Int): Boolean {
    val grid = Array(height) { CharArray(width) { '.' } }
    
    robots.forEach { robot ->
        grid[robot.position.y][robot.position.x] = '#'
    }
    
    val pattern = listOf(
        "....#....",
        "...###...",
        "..#####..",
        ".#######.",
        "#########"
    )
    
    for (y in 0 until height - pattern.size) {
        for (x in 0 until width - pattern[0].length) {
            if (matchesPattern(grid, pattern, x, y)) {
                return true
            }
        }
    }
    
    return false
}

fun matchesPattern(grid: Array<CharArray>, pattern: List<String>, startX: Int, startY: Int): Boolean {
    for (y in pattern.indices) {
        for (x in pattern[y].indices) {
            if (pattern[y][x] == '#' && grid[startY + y][startX + x] != '#') {
                return false
            }
        }
    }
    return true
}