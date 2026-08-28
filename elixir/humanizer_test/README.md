# humanizer_test

Reproduction for the `humanizer` Elixir library (https://github.com/ivan-podgurskiy/humanizer),
tested as a maintained alternative to `Timex` (which reproduced the Norfolk Island bug --
see `../tztest/`).

`Humanizer.relative_time/2,3` is clean on both the Norfolk Island permanent offset-change
case and the Dublin DST fall-back case, and (unlike `Timex.Format.Duration.Formatters.Humanized.format/2`,
see [bitwalker/timex#794](https://github.com/bitwalker/timex/pull/794)) handles reversed
argument order (`finish` before `start`) without crashing, since it diffs absolute instants
and branches on sign rather than doing calendar-aware year/month shifting.

Run with:

```
mix deps.get && mix run test.exs
```
