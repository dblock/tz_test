<?php
date_default_timezone_set('Europe/Dublin');

$start = new DateTime('2024-10-27 01:59:30');
$finish = clone $start;
$finish->modify('+1 minute');

echo "start offset: " . $start->getOffset() . "\n";
echo "finish offset: " . $finish->getOffset() . "\n";

$diff = $start->diff($finish);
echo "diff: {$diff->y}y {$diff->m}m {$diff->d}d {$diff->h}h {$diff->i}min {$diff->s}s\n";
