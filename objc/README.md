# objc

Reproduction using Apple's `Foundation` formatters via the Objective-C API surface:
`NSDateComponentsFormatter` and `NSRelativeDateTimeFormatter`.

Both are clean on the Norfolk Island permanent offset-change case, the Dublin DST
fall-back case, reversed argument order, and zero distance.

`NSDateComponentsFormatter` was initially flagged as a candidate bug: given a reversed
`(fromDate, toDate)` pair it renders `"-1 year, 2 months"` rather than
`"-1 year, -2 months"`. This turned out not to be a bug -- it's standard mixed-radix
negative notation, the same convention used for negative durations (`-1:30:00` means
minus one-and-a-half hours, not "minus one hour plus thirty minutes") or negative
degrees/minutes/seconds coordinates: only the leading unit carries the sign, and the rest
are magnitudes within that negative quantity. `NSCalendar` confirms this is intentional --
`[cal components:...fromDate:finish toDate:start]` returns fully-negative components
(`year=-1, month=-2`) under the hood, and the formatter correctly collapses that into a
single leading sign for display.

Run with:

```
clang -framework Foundation -fobjc-arc main.m -o main && ./main
```
