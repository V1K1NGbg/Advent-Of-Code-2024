// scalac 23.2.scala
// scala TwentyThreeTwo

object TwentyThreeTwo {
  def main(args: Array[String]): Unit = {
    val raw = scala.io.Source
      .fromFile("input/23.txt")
      .mkString
    val pairs = raw.trim
      .split("\n")
      .map { line =>
        val Array(a, b) = line.split("-")
        (a, b)
      }
      .toList
    println(solution(pairs))
  }

  def findNetworksLevelN(
      prevLevel: List[Set[String]],
      connections: Map[String, Set[String]],
      n: Int
  ): List[Set[String]] = {
    val nextLevel = scala.collection.mutable.Set.empty[Set[String]]
    for (prev <- prevLevel) {
      prev.toList
        .map(connections)
        .reduce(_ intersect _)
        .foreach(intersection => {
          val candidate = prev + intersection
          nextLevel += candidate
        })
    }
    nextLevel.toList
  }

  def solution(pairs: List[(String, String)]): String = {
    val tmp = scala.collection.mutable.Map.empty[String, Set[String]]
    pairs.foreach { case (a, b) =>
      tmp(a) = tmp.getOrElse(a, Set.empty) + b
      tmp(b) = tmp.getOrElse(b, Set.empty) + a
    }
    val connections = tmp.toMap

    var curentLevel = pairs.map(p => Set(p._1, p._2))
    var nextLevel = findNetworksLevelN(curentLevel, connections, 2)
    while (nextLevel.nonEmpty) {
      curentLevel = nextLevel
      nextLevel = findNetworksLevelN(curentLevel, connections, 2)
    }
    curentLevel.head.toList.sorted.mkString(",")
  }
}
