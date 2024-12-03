# nix-instantiate --eval 2.1.nix

with import <nixpkgs> {};

let
    rawReports = builtins.readFile ./2.txt;

    lines = lib.splitString "\n" rawReports;

    parseInt = str: builtins.fromJSON str;

    parseLine = line: builtins.map (x: parseInt x) (lib.splitString " " line);

    reports = builtins.filter (line: line != "") (builtins.map parseLine lines);

    isSafe = levels:
        let
            diff = builtins.map (i: builtins.elemAt levels (i + 1) - builtins.elemAt levels i) (lib.range 0 (builtins.length levels - 2));
            
            isInc = builtins.all (x: x >= 1 && x <= 3) diff;

            isDec = builtins.all (x: x >= -3 && x <= -1) diff;
        in
            isInc || isDec;

    safe = builtins.filter isSafe reports;
in
    builtins.length safe
