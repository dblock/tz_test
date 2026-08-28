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

Only `Timex` reproduced a bug, and it's the same shape as `dotiw`'s original Norfolk
failure: the real 30-minute offset delta leaks out as a spurious trailing unit in the
compound breakdown, instead of being absorbed cleanly into "1 year, 2 months". A fix
is proposed in [`bitwalker/timex` PR #793](https://github.com/bitwalker/timex/pull/793).

Most other libraries avoid the trap structurally, either by rounding to a single largest
unit ("about 1 year", "a minute ago") with no calendar-shaped bucket for a stray remainder
to leak into, or (in `Carbon`'s case) by getting the offset math right underneath, at the
`DateInterval` level, before any splitting into units occurs.

## Running the tests

Each directory is a standalone scratch project for one language/runtime:

- `js/` — `npm install && node test_date_fns.mjs && node test_dayjs.mjs && node test_moment.mjs && node test_dublin.mjs && node test_dublin2.mjs`
- `test_python.py` / `test_python_dublin.py` — `pip install humanize arrow && python3 test_python.py`
- `go/` — `go run main.go`
- `rust/` — `cargo run`
- `php/` — `composer install && php test_norfolk.php && php test_dublin.php && php test_carbon.php`
- `dotnet/` — `dotnet add package Humanizer && dotnet run`
- `java/` — download [PrettyTime](https://mvnrepository.com/artifact/org.ocpsoft.prettytime/prettytime) to `java/lib/prettytime.jar`, then `javac -cp lib/prettytime.jar TzTest.java && java -cp .:lib/prettytime.jar TzTest`
- `elixir/tztest/` — `mix deps.get && mix run test.exs`

Related blog post: [Adventures in Daylight Saving, Norfolk Island, and Time Zone Math (in Ruby)](https://code.dblock.org/2026/08/28/adventures-in-daylight-saving-norfolk-island-and-time-zone-math-in-ruby.html)
