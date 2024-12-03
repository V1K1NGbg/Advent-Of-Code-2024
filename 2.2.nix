# nix-instantiate --eval 2.2.nix --extra-experimental-features pipe-operators

# Heavily influenced by https://git.sr.ht/~kintrix/

with (import <nixpkgs> { }).lib;

let
  removeAt = idx: xs:
    if idx == 0 then
      tail xs
    else
      concat [ (head xs) ] <| removeAt (idx - 1) (tail xs);
  groupsOf =
    n: xs:
    if length xs < n then
      [ ]
    else
      concat [ (range 0 (n - 1) |> (map (elemAt xs))) ] <| groupsOf n (tail xs);

  input = builtins.readFile ./2.txt |> trim;

  rawData = pipe input [
    (splitString "\n")
    (map (x: map toInt <| splitString " " x))
  ];

  getDiffs =
    xs:
    pipe xs [
      (groupsOf 2)
      (map (pair: elemAt pair 1 - elemAt pair 0))
    ];

  dropOne = xs: map (idx: removeAt idx xs) <| range 0 (length xs - 1);

  dampenedSafety = pipe rawData [
    (map dropOne)
    (map (map getDiffs))
    (map (any (xs: all (x: 0 < x && x <= 3) xs || all (x: -3 <= x && x < 0) xs)))
  ];
in
 dampenedSafety |> count id