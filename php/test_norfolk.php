<?php
date_default_timezone_set('Pacific/Norfolk');

$start = new DateTime('2015-01-15 00:00:00');
$finish = new DateTime('2016-03-15 00:00:00');

echo "start offset: " . $start->getOffset() . "\n";
echo "finish offset: " . $finish->getOffset() . "\n";

$diff = $start->diff($finish);
echo "diff: {$diff->y}y {$diff->m}m {$diff->d}d {$diff->h}h {$diff->i}min {$diff->s}s\n";
