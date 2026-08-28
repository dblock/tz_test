<?php
require 'vendor/autoload.php';
use Carbon\Carbon;

Carbon::setLocale('en');
$a = Carbon::create(2015, 1, 15, 0, 0, 0, 'UTC');
$b = Carbon::create(2016, 3, 15, 0, 0, 0, 'UTC');

echo "--- reversed order (finish before start) ---\n";
echo "Carbon diffForHumans forward: " . $a->diffForHumans($b) . "\n";
echo "Carbon diffForHumans reversed: " . $b->diffForHumans($a) . "\n";

echo "--- zero distance (same instant) ---\n";
echo "Carbon diffForHumans: " . $a->diffForHumans($a) . "\n";

// native DateTime::diff
$da = new DateTime('2015-01-15T00:00:00Z');
$db = new DateTime('2016-03-15T00:00:00Z');
$fwd = $da->diff($db);
$rev = $db->diff($da);
echo "native diff forward invert flag: {$fwd->invert}, {$fwd->y}y {$fwd->m}m {$fwd->d}d\n";
echo "native diff reversed invert flag: {$rev->invert}, {$rev->y}y {$rev->m}m {$rev->d}d\n";
