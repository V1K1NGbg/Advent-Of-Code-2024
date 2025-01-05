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
    
    repeat(100) {
        moveRobots(robots, width, height)
    }
    
    val quadrantCounts = countRobotsInQuadrants(robots, width, height)
    val safetyFactor = quadrantCounts.reduce { acc, count -> acc * count }
    
    println(safetyFactor)
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

fun countRobotsInQuadrants(robots: List<Robot>, width: Int, height: Int): List<Int> {
    val midX = width / 2
    val midY = height / 2
    val quadrants = MutableList(4) { 0 }
    
    robots.forEach { robot ->
        when {
            robot.position.x == midX || robot.position.y == midY -> return@forEach
            robot.position.x < midX && robot.position.y < midY -> quadrants[0]++
            robot.position.x > midX && robot.position.y < midY -> quadrants[1]++
            robot.position.x < midX && robot.position.y > midY -> quadrants[2]++
            robot.position.x > midX && robot.position.y > midY -> quadrants[3]++
        }
    }
    
    return quadrants
}