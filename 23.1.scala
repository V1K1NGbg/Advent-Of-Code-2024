// scalac 23.1.scala
// scala TwentyThreeOne

object TwentyThreeOne {
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

  def triples(
      pairs: List[(String, String)]
  ): List[(String, String, String)] = {
    val connections = scala.collection.mutable.Map.empty[String, Set[String]]
    val triples =
      scala.collection.mutable.Set.empty[(String, String, String)]

    pairs.foreach { case (a, b) =>
      val aSet = connections.getOrElse(a, Set.empty)
      val bSet = connections.getOrElse(b, Set.empty)

      aSet.intersect(bSet).foreach { c =>
        triples += ((a, b, c))
      }
      connections(a) = aSet + b
      connections(b) = bSet + a
    }

    triples.toList
  }

  def solution(pairs: List[(String, String)]): Int = {
    val tri = triples(pairs)
    tri.count(t =>
      t._1.startsWith("t") || t._2.startsWith("t") || t._3.startsWith("t")
    )
  }
}
