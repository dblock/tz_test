Application.ensure_all_started(:timex)
Application.ensure_all_started(:tzdata)

# Norfolk Island permanent offset change
{:ok, start} = DateTime.new(~D[2015-01-15], ~T[00:00:00], "Pacific/Norfolk", Tzdata.TimeZoneDatabase)
{:ok, finish} = DateTime.new(~D[2016-03-15], ~T[00:00:00], "Pacific/Norfolk", Tzdata.TimeZoneDatabase)

IO.puts("start offset: #{start.utc_offset + start.std_offset}")
IO.puts("finish offset: #{finish.utc_offset + finish.std_offset}")

diff_seconds = DateTime.diff(finish, start)
IO.puts("Norfolk raw diff (seconds): #{diff_seconds}")
IO.puts("Norfolk raw diff (days): #{div(diff_seconds, 86400)}")

IO.puts("Norfolk Timex duration (humanized): #{Timex.Format.Duration.Formatters.Humanized.format(Timex.Duration.from_seconds(diff_seconds))}")

# Dublin DST transition
{:ambiguous, dstart, _} = DateTime.new(~D[2024-10-27], ~T[01:59:30], "Europe/Dublin", Tzdata.TimeZoneDatabase)
dfinish = DateTime.add(dstart, 60, :second)

IO.puts("\nDublin start offset: #{dstart.utc_offset + dstart.std_offset}")
IO.puts("Dublin finish offset: #{dfinish.utc_offset + dfinish.std_offset}")
IO.puts("Dublin raw diff (seconds): #{DateTime.diff(dfinish, dstart)}")
IO.puts("Dublin Timex duration (humanized): #{Timex.Format.Duration.Formatters.Humanized.format(Timex.Duration.from_seconds(DateTime.diff(dfinish, dstart)))}")

# Reversed order (finish before start), via format/1 with a signed Duration
# (published Timex only has format/1; format/2 is proposed in
# bitwalker/timex#793/#794 and isn't in the released hex package yet)
reversed_seconds = DateTime.diff(start, finish)
IO.puts("\nReversed order format/1: #{Timex.Format.Duration.Formatters.Humanized.format(Timex.Duration.from_seconds(reversed_seconds))}")

# Zero distance
IO.puts("\nZero distance format/1: #{Timex.Format.Duration.Formatters.Humanized.format(Timex.Duration.from_seconds(0))}")
