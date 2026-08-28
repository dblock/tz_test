# objc

Reproduction using Apple's `Foundation` formatters via the Objective-C API surface:
`NSDateComponentsFormatter` and `NSRelativeDateTimeFormatter`.

`NSRelativeDateTimeFormatter` is clean on all cases (Norfolk, Dublin, reversed order,
zero distance), same as Swift's `RelativeDateTimeFormatter` (same underlying
implementation).

**`NSDateComponentsFormatter` has a real bug on reversed argument order** (also present
in Swift's `DateComponentsFormatter` -- same underlying implementation, see
`../swift/README.md`). `NSCalendar` itself correctly computes all-negative components
when `toDate` precedes `fromDate` (e.g. `year=-1 month=-2`), but
`NSDateComponentsFormatter` only negates the *first* nonzero unit and leaves the rest
positive, producing an internally inconsistent string:

```objc
// forward: "1 year, 2 months"
// reversed: "-1 year, 2 months"   <- should be "-1 year, -2 months" (or "1 year, 2 months ago")
```

This reproduces with `.full`, `.positional`, and `.abbreviated` unit styles, and with
more than two units (tested with a 3-year/5-month/14-day span, same pattern). Not
reported upstream since Apple doesn't have a public bug tracker for this the way
`bitwalker/timex` does -- filed via Feedback Assistant would be the appropriate channel
for a real app depending on this.

Run with:

```
clang -framework Foundation -fobjc-arc main.m -o main && ./main
```
