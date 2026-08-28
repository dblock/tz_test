using System;
using Humanizer;

// Norfolk Island permanent offset change
var norfolk = TimeZoneInfo.FindSystemTimeZoneById("Pacific/Norfolk");
var start = new DateTimeOffset(2015, 1, 15, 0, 0, 0, norfolk.GetUtcOffset(new DateTime(2015, 1, 15)));
var finish = new DateTimeOffset(2016, 3, 15, 0, 0, 0, norfolk.GetUtcOffset(new DateTime(2016, 3, 15)));

Console.WriteLine($"start offset: {start.Offset}");
Console.WriteLine($"finish offset: {finish.Offset}");
Console.WriteLine($"Norfolk raw diff: {finish - start}");
Console.WriteLine($"Norfolk Humanize: {(finish - start).Humanize(precision: 5)}");

// Dublin DST transition
var dublin = TimeZoneInfo.FindSystemTimeZoneById("Europe/Dublin");
var dstartLocal = new DateTime(2024, 10, 27, 1, 59, 30, DateTimeKind.Unspecified);
bool ambiguous = dublin.IsAmbiguousTime(dstartLocal);
Console.WriteLine($"\nDublin 01:59:30 is ambiguous: {ambiguous}");
var offsets = dublin.GetAmbiguousTimeOffsets(dstartLocal);
Console.WriteLine($"Possible offsets: {string.Join(", ", offsets)}");

var dstart = new DateTimeOffset(dstartLocal, offsets[0]); // earliest/IST occurrence
var dfinish = dstart.AddMinutes(1);
Console.WriteLine($"Dublin start offset: {dstart.Offset}");
Console.WriteLine($"Dublin finish offset: {dfinish.Offset}");
Console.WriteLine($"Dublin raw diff: {dfinish - dstart}");
Console.WriteLine($"Dublin Humanize: {(dfinish - dstart).Humanize(precision: 5)}");

// reversed order (finish before start) and zero distance
Console.WriteLine();
Console.WriteLine($"Reversed Humanize (start - finish): {(start - finish).Humanize(precision: 5)}");
Console.WriteLine($"Zero distance Humanize: {(start - start).Humanize(precision: 5)}");
