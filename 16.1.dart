import 'dart:math';
import 'dart:io';

void main() {
  var lines = File("input/16.txt").readAsLinesSync();
  var m = Mapp(lines);
  print(m.calculate());
}

typedef Point = (int, int);

enum Dir {
  None(0,0),
  North(-1, 0),
  South(1, 0),
  East(0, 1),
  West(0, -1);

  final int x;
  final int y;
  const Dir(this.x, this.y);

  static Dir fromPoints(Point from, Point to){
    if(from.$1 == to.$1){
      return (from.$2 < to.$2)?Dir.East:Dir.West;
    }
    if(from.$2 == to.$2){
      return (from.$1 < to.$1)?Dir.South:Dir.North;
    }
    return None;
  }

  static List<Dir> valids(){
    return [Dir.North, Dir.South, Dir.East, Dir.West];
  }

  Dir turnLeft() {
    switch (this) {
      case North:
        return West;
      case South:
        return East;
      case East:
        return North;
      case West:
        return South;
      default:
        return None;
    }
  }

  Dir turnRight() {
    switch (this) {
      case North:
        return East;
      case South:
        return West;
      case East:
        return South;
      case West:
        return North;
      default:
        return None;
    }
  }

  Dir halfTurn(){
    switch (this) {
      case North:
        return South;
      case South:
        return North;
      case East:
        return West;
      case West:
        return East;
      default:
        return None;
    }
  }

  Point add(Point p) {
    return (p.$1 + x, p.$2 + y);
  }
}

class Mapp {
  final List<String> map;
  Mapp(this.map);

  bool isWall(Point p) {
    return map[p.$1][p.$2] == "#";
  }

  int calculate() {
    var unvisited = <(Point, Dir)>{};
    for(int i=0; i<map.length; ++i){
      for(int j=0; j<map[i].length; ++j){
        var c = (i,j);
        if(isWall(c)) continue;
        for(var d in Dir.valids()){
          if(isWall(d.add(c))) continue;
          unvisited.add((c, d.halfTurn()));
        }
      }
    }

    int infinity = 1000 * map.length * map[0].length;
    var distances = {for (var v in unvisited) v: DData(infinity)};

    var start = (map.length - 2, 1);
    var startData = DData(0)..nodes.add(start);
    distances[(start, Dir.East)] = startData;
    unvisited.add((start, Dir.East));

    while (!unvisited.isEmpty) {
      var next = ((0, 0), Dir.None);
      var minCost = infinity;
      for (var v in unvisited) {
        if (distances[v]!.cost < minCost) {
          minCost = distances[v]!.cost;
          next = v;
        }
      }
      if (minCost == infinity) break;

      for( var d in [next.$2, next.$2.turnLeft(), next.$2.turnRight()]){
        var c = d.add(next.$1);
        if(isWall(c)) continue;

        var cost = minCost + 1;
        if(d != next.$2) cost += 1000;

        var node = (c,d);
        if(cost == distances[node]!.cost){
          distances[node]!.nodes.addAll(distances[next]!.nodes);
          distances[node]!.nodes.add(c);
        }
        else if(cost < distances[node]!.cost){
          var d = DData(cost);
          d.nodes.addAll(distances[next]!.nodes);
          d.nodes.add(c);
          distances[node] = d;
        }
      }
      unvisited.remove(next);
    }

    var end = (1, map.length - 2);
    var ends = [for (var d in Dir.valids()) (end,d)];
    var endDistance = infinity;
    for(var e in ends){
      if(!distances.containsKey(e)) continue;
      if(distances[e]!.cost < endDistance)
      {
        endDistance = distances[e]!.cost;
      } 
    }
    return endDistance;

  }
}

class DData{
  int cost;
  var nodes = <Point>{};

  DData(this.cost);
}