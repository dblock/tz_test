# timex

Reproduction for `Timex` (https://github.com/bitwalker/timex), which reproduces the
Norfolk Island permanent UTC offset-change bug -- see the top-level
[README](../../README.md) for the full write-up. A fix was proposed in
[bitwalker/timex#793](https://github.com/bitwalker/timex/pull/793), and a follow-up fix
for a crash on reversed argument order in
[bitwalker/timex#794](https://github.com/bitwalker/timex/pull/794).

Run with:

```
mix deps.get && mix run test.exs
```
