import 'package:timeago/timeago.dart' as timeago;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzdata;

void main() {
  tzdata.initializeTimeZones();

  // Norfolk Island permanent offset change: +11:30 -> +11:00 on 2015-10-04
  final norfolk = tz.getLocation('Pacific/Norfolk');
  final start = tz.TZDateTime(norfolk, 2015, 1, 15);
  final finish = tz.TZDateTime(norfolk, 2016, 3, 15);

  print('Norfolk start offset: ${start.timeZoneOffset}');
  print('Norfolk finish offset: ${finish.timeZoneOffset}');
  print('Norfolk timeago forward: ${timeago.format(start, clock: finish)}');
  print(
      'Norfolk timeago reversed: ${timeago.format(finish, clock: start, allowFromNow: true)}');
  print('Norfolk timeago zero: ${timeago.format(start, clock: start)}');

  // Europe/Dublin DST fall-back: 2024-10-27 01:59:30 IST -> 01:00:30 GMT one
  // minute later (real elapsed instants, constructed via UTC to avoid
  // ambiguity)
  final dublin = tz.getLocation('Europe/Dublin');
  final dstartUtc = tz.TZDateTime.utc(2024, 10, 27, 0, 59, 30);
  final dfinishUtc = dstartUtc.add(const Duration(minutes: 1));
  final dstart = tz.TZDateTime.from(dstartUtc, dublin);
  final dfinish = tz.TZDateTime.from(dfinishUtc, dublin);

  print('\nDublin start offset: ${dstart.timeZoneOffset}');
  print('Dublin finish offset: ${dfinish.timeZoneOffset}');
  print('Dublin timeago forward: ${timeago.format(dstart, clock: dfinish)}');
  print(
      'Dublin timeago reversed: ${timeago.format(dfinish, clock: dstart, allowFromNow: true)}');
  print('Dublin timeago zero: ${timeago.format(dstart, clock: dstart)}');
}
