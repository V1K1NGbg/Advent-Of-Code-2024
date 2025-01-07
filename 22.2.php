<?php
// php 22.2.php

ini_set('memory_limit', '4G');

$input = file_get_contents(__DIR__ . "/input/22.txt");

$lines = explode("\n", $input);
$lines = array_map('intval', $lines);

$seqs = [];

foreach ($lines as $id => $num) {
    unset($last);
    $window = [];

    for ($i = 0; $i <= 2000; $i++) {
        $new = $num % 10;
        if (isset($last)) {
            $window[] = $new - $last;
        }

        $last = $new;

        $num = (($num * 64) ^ $num) % 16777216;
        $num = ((floor($num / 32)) ^ $num) % 16777216;
        $num = (($num * 2048) ^ $num) % 16777216;

        if (count($window) === 4) {
            $seqs[implode(',', $window)][$id] ??= $new;
            array_shift($window);
        }
    }
}

echo max(array_map('array_sum', $seqs)) . PHP_EOL;

