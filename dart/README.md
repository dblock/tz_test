# dart

Reproduction for the `timeago` package (https://pub.dev/packages/timeago), using the
`timezone` package (https://pub.dev/packages/timezone) for IANA tzdata-aware datetimes.

Clean on the Norfolk Island permanent offset-change case, the Dublin DST fall-back case,
reversed argument order (via `allowFromNow: true`), and zero distance. Rounds to a single
largest unit, like most of the other libraries tested here, so there's no calendar-shaped
bucket for a stray offset remainder to leak into.

Run with:

```
dart pub get && dart run main.dart
```
