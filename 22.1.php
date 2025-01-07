<?php
// php 22.1.php

ini_set('memory_limit', '4G');

$input = file_get_contents(__DIR__ . "/input/22.txt");

$lines = explode("\n", $input);
$lines = array_map('intval', $lines);

$sum = 0;

foreach ($lines as $num) {
    for ($i = 0; $i < 2000; $i++) {
        $num = (($num * 64) ^ $num) % 16777216;
        $num = ((floor($num / 32)) ^ $num) % 16777216;
        $num = (($num * 2048) ^ $num) % 16777216;
    }
    $sum += $num;
}

echo $sum . PHP_EOL;
