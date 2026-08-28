# swift

Reproduction using Apple's built-in `Foundation` formatters: `DateComponentsFormatter`
(compound calendar-unit breakdown, analogous to `dotiw`) and `RelativeDateTimeFormatter`
(single-largest-unit "time ago" style).

Both are clean on the Norfolk Island permanent offset-change case and the Dublin DST
fall-back case. `RelativeDateTimeFormatter` is also clean on reversed argument order and
zero distance.

**`DateComponentsFormatter` has a real bug on reversed argument order**, shared with
Objective-C's `NSDateComponentsFormatter` (same underlying implementation) -- see
`../objc/README.md` for the full writeup:

```swift
// forward:  "1 year, 2 months"
// reversed: "-1 year, 2 months"   <- should read "-1 year, -2 months", or "1 year, 2 months ago"
```

Run with:

```
swift main.swift
```
