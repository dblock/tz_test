# Norfolk Island permanent offset change (+11:30 -> +11:00 on 2015-10-04)
{:ok, start, 0} = DateTime.from_iso8601("2015-01-15T00:00:00Z")
{:ok, finish, 0} = DateTime.from_iso8601("2016-03-15T00:00:00Z")

IO.puts("Norfolk relative_time: #{Humanizer.relative_time(start, finish)}")

# Europe/Dublin DST fall-back (2024-10-27 01:59:30 IST -> 01:00:30 GMT one
# minute later, real elapsed instants expressed directly in UTC)
{:ok, dstart, 0} = DateTime.from_iso8601("2024-10-27T00:59:30Z")
{:ok, dfinish, 0} = DateTime.from_iso8601("2024-10-27T01:00:30Z")

IO.puts("Dublin relative_time: #{Humanizer.relative_time(dstart, dfinish)}")

# Reversed order (finish before start) -- this crashed Timex's format/2
# (github.com/bitwalker/timex/pull/794); relative_time handles it natively.
IO.puts("Reversed order relative_time: #{Humanizer.relative_time(finish, start)}")
