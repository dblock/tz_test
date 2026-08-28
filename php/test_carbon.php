<?php
require 'vendor/autoload.php';
use Carbon\Carbon;

// Norfolk Island
Carbon::setLocale('en');
$start = Carbon::create(2015, 1, 15, 0, 0, 0, 'Pacific/Norfolk');
$finish = Carbon::create(2016, 3, 15, 0, 0, 0, 'Pacific/Norfolk');
echo "start offset: " . $start->getOffset() . "\n";
echo "finish offset: " . $finish->getOffset() . "\n";
echo "Norfolk diffForHumans: " . $start->diffForHumans($finish) . "\n";
echo "Norfolk diff (verbose): " . $start->diff($finish)->forHumans() . "\n";
$diff = $start->diff($finish);
echo "Norfolk raw diff: {$diff->y}y {$diff->m}m {$diff->d}d {$diff->h}h {$diff->i}min {$diff->s}s\n";

// Dublin DST
$dstart = Carbon::create(2024, 10, 27, 1, 59, 30, 'Europe/Dublin');
$dfinish = $dstart->copy()->addMinute();
echo "\nDublin start offset: " . $dstart->getOffset() . "\n";
echo "Dublin finish offset: " . $dfinish->getOffset() . "\n";
echo "Dublin diffForHumans: " . $dstart->diffForHumans($dfinish) . "\n";
$ddiff = $dstart->diff($dfinish);
echo "Dublin raw diff: {$ddiff->y}y {$ddiff->m}m {$ddiff->d}d {$ddiff->h}h {$ddiff->i}min {$ddiff->s}s\n";
