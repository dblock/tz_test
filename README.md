# tz_test

Reproductions testing whether two real timezone bugs found and fixed in Ruby's
[`distance_of_time_in_words`](https://github.com/radar/distance_of_time_in_words) gem
(see [`dotiw` issues #63 and #153](https://github.com/radar/distance_of_time_in_words/issues))
also occur in similar "humanize a time difference" libraries across other languages.

## The two bugs

1. **Dublin `dst?` bug**: a library incorrectly used a timezone's `dst?`/DST flag instead
   of comparing actual UTC offsets, causing incorrect distance calculations across
   `Europe/Dublin`'s DST transition (Ireland's tz database entry is inverted: winter is DST).
2. **Norfolk Island offset-change bug**: a library assumed any offset change was a
   recurring ±1 hour DST transition, breaking when `Pacific/Norfolk` permanently changed
   its UTC offset from +11:30 to +11:00 on 4 October 2015 (a one-time, non-DST change).

## Results

| Language | Library | Norfolk bug? | Dublin bug? |
|---|---|---|---|
| Ruby | `dotiw` (latest, 5.6.0) | No (fixed upstream) | No (fixed upstream) |
| JavaScript | `date-fns` | No | No |
| JavaScript | `dayjs` | No | No |
| JavaScript | `moment.js` | No | No |
| Python | `humanize` | No | No |
| Python | `arrow` | No | No |
| Go | `go-humanize` | No | No |
| Rust | `chrono-humanize` | No | No |
| PHP | native `DateTime::diff` | No | No |
| PHP | `Carbon` | No | No |
| C# | `Humanizer` | No | No |
| Java | `PrettyTime` | No | No |
| **Elixir** | **`Timex`** | **Yes — "1 year, 2 months, 30 minutes"** | No |
| Elixir | `humanizer` | No | No |
| Swift | `DateComponentsFormatter` | No | No |
| Objective-C | `NSDateComponentsFormatter` | No | No |
| Dart | `timeago` | No | No |

Only `Timex` reproduced a bug, and it's the same shape as `dotiw`'s original Norfolk
failure: the real 30-minute offset delta leaks out as a spurious trailing unit in the
compound breakdown, instead of being absorbed cleanly into "1 year, 2 months". A fix
is proposed in [`bitwalker/timex` PR #793](https://github.com/bitwalker/timex/pull/793).

`Timex` is largely unmaintained at this point (last push mid-2025, 70+ open issues), so
we also tried [`humanizer`](https://github.com/ivan-podgurskiy/humanizer), an actively
maintained, English-only alternative. Its `relative_time/2,3` is clean on both cases, and
it also correctly handles reversed argument order (`finish` before `start`) without
crashing — unlike `Timex`'s `format/2`, which raised in that case
([bitwalker/timex#794](https://github.com/bitwalker/timex/pull/794)). `humanizer` avoids
the whole bug class structurally: it diffs absolute instants and branches on sign, rather
than doing calendar-aware year/month shifting.

Most other libraries avoid the trap structurally, either by rounding to a single largest
unit ("about 1 year", "a minute ago") with no calendar-shaped bucket for a stray remainder
to leak into, or (in `Carbon`'s case) by getting the offset math right underneath, at the
`DateInterval` level, before any splitting into units occurs.

## Other edge cases tested

Beyond the two timezone-specific bugs, we also went through `dotiw`'s own test suite for
other categories of edge cases worth checking across languages: reversed argument order
(`finish` chronologically before `start`) and zero distance (same instant twice).

| Language | Library | Reversed order | Zero distance |
|---|---|---|---|
| Ruby | `dotiw` (latest, 5.6.0) | OK | OK |
| JavaScript | `date-fns` | OK | OK |
| JavaScript | `dayjs` | OK | OK |
| JavaScript | `moment.js` | OK | OK |
| Python | `humanize` | OK | OK |
| Python | `arrow` | OK | OK |
| Go | `go-humanize` | OK | OK |
| Rust | `chrono-humanize` | OK | OK |
| PHP | native `DateTime::diff` | OK (`invert` flag) | OK |
| PHP | `Carbon` | OK | OK |
| C# | `Humanizer` | OK | OK |
| Java | `PrettyTime` | OK | OK |
| Elixir | `Timex` (`format/1`) | OK | OK |
| **Elixir** | **`Timex` (`format/2`, PR #793)** | **Crashed — fixed in [PR #794](https://github.com/bitwalker/timex/pull/794)** | OK |
| Elixir | `humanizer` | OK | OK |
| Swift | `DateComponentsFormatter` | OK | OK |
| Swift / Objective-C | `RelativeDateTimeFormatter` | OK | OK |
| Objective-C | `NSDateComponentsFormatter` | OK | OK |
| Dart | `timeago` | OK | OK |

The one new bug found in Timex was in the `format/2` API added by our own PR #793: it
assumed `start <= finish` and passed a negative year/month count straight into Gettext's
plural translation, which requires a non-negative count, raising a `FunctionClauseError`.
`format/1` (and every other library tested) has always been sign-independent for this
kind of input, so this was a regression specific to the new API, not an issue in released
Timex or in any other library. It's fixed in
[bitwalker/timex#794](https://github.com/bitwalker/timex/pull/794) by normalizing the
order of `start`/`finish` before doing the calendar-aware diff/shift arithmetic.

**A candidate bug considered, then ruled out**: `NSDateComponentsFormatter` (also Swift's
`DateComponentsFormatter`, same underlying implementation) renders a reversed
`(fromDate, toDate)` pair as `"-1 year, 2 months"` rather than `"-1 year, -2 months"`.
This looked like a sign-dropping bug at first, but it's actually standard mixed-radix
negative notation — the same convention used for negative durations like `-1:30:00` (one
and a half hours negative, not "minus one hour plus thirty minutes") or negative
degrees/minutes/seconds in geographic coordinates: only the leading unit carries the
sign, and the rest are magnitudes of the same negative quantity. `NSCalendar` confirms
this reading is intentional — it returns fully-negative components (`year=-1, month=-2`)
under the hood, and the formatter correctly collapses that into a single leading sign for
display. Not a bug; see `objc/README.md` for the reproduction and reasoning.

## Running the tests

Each directory is a standalone scratch project for one language/runtime:

- `ruby/` — `bundle install && bundle exec ruby test.rb`
- `js/` — `npm install && node test_date_fns.mjs && node test_dayjs.mjs && node test_moment.mjs && node test_dublin.mjs && node test_dublin2.mjs && node test_edge_cases.mjs`
- `python/` — `pip install humanize arrow && python3 python/test_python.py`
- `go/` — `go run .`
- `rust/` — `cargo run`
- `php/` — `composer install && php test_norfolk.php && php test_dublin.php && php test_carbon.php && php test_edge_cases.php`
- `dotnet/` — `dotnet add package Humanizer && dotnet run`
- `java/` — download [PrettyTime](https://mvnrepository.com/artifact/org.ocpsoft.prettytime/prettytime) to `java/lib/prettytime.jar`, then `javac -cp lib/prettytime.jar TzTest.java && java -cp .:lib/prettytime.jar TzTest`
- `elixir/timex/` — `mix deps.get && mix run test.exs`
- `elixir/humanizer_test/` — `mix deps.get && mix run test.exs`
- `swift/` — `swift main.swift` (macOS only)
- `objc/` — `clang -framework Foundation -fobjc-arc main.m -o main && ./main` (macOS only)
- `dart/` — `dart pub get && dart run main.dart`

Related blog post: [Adventures in Daylight Saving, Norfolk Island, and Time Zone Math (in Ruby)](https://code.dblock.org/2026/08/28/adventures-in-daylight-saving-norfolk-island-and-time-zone-math-in-ruby.html)
