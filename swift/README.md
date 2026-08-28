# swift

Reproduction using Apple's built-in `Foundation` formatters: `DateComponentsFormatter`
(compound calendar-unit breakdown, analogous to `dotiw`) and `RelativeDateTimeFormatter`
(single-largest-unit "time ago" style).

Both are clean on the Norfolk Island permanent offset-change case, the Dublin DST
fall-back case, reversed argument order, and zero distance. See `../objc/README.md` for
a note on why `DateComponentsFormatter`'s reversed-order output (`"-1 year, 2 months"`)
is correct mixed-radix negative notation, not a sign-dropping bug.

Run with:

```
swift main.swift
```
