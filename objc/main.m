#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Norfolk Island permanent offset change: +11:30 -> +11:00 on 2015-10-04
        NSTimeZone *norfolk = [NSTimeZone timeZoneWithName:@"Pacific/Norfolk"];
        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        cal.timeZone = norfolk;

        NSDateComponents *startComps = [[NSDateComponents alloc] init];
        startComps.year = 2015; startComps.month = 1; startComps.day = 15;
        NSDate *start = [cal dateFromComponents:startComps];

        NSDateComponents *finishComps = [[NSDateComponents alloc] init];
        finishComps.year = 2016; finishComps.month = 3; finishComps.day = 15;
        NSDate *finish = [cal dateFromComponents:finishComps];

        NSLog(@"Norfolk start offset: %ld", (long)[norfolk secondsFromGMTForDate:start]);
        NSLog(@"Norfolk finish offset: %ld", (long)[norfolk secondsFromGMTForDate:finish]);

        NSDateComponentsFormatter *dcFormatter = [[NSDateComponentsFormatter alloc] init];
        dcFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;
        dcFormatter.allowedUnits = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
        dcFormatter.calendar = cal;
        NSLog(@"Norfolk DateComponentsFormatter: %@", [dcFormatter stringFromDate:start toDate:finish]);
        NSLog(@"Norfolk DateComponentsFormatter reversed: %@", [dcFormatter stringFromDate:finish toDate:start]);
        NSLog(@"Norfolk DateComponentsFormatter zero: %@", [dcFormatter stringFromDate:start toDate:start]);

        // NSDateComponentsFormatter's reversed-order output above is
        // internally inconsistent: NSCalendar itself correctly returns all
        // components negative, but the formatter only negates the first
        // nonzero unit, producing a misleading string like "-1 year, 2
        // months" instead of "-1 year, -2 months" (or "1 year, 2 months
        // ago").
        NSDateComponents *rawReversed = [cal components:(NSCalendarUnitYear | NSCalendarUnitMonth)
                                                fromDate:finish toDate:start options:0];
        NSLog(@"Norfolk raw NSCalendar components (finish->start): year=%ld month=%ld",
              (long)rawReversed.year, (long)rawReversed.month);

        NSRelativeDateTimeFormatter *rFormatter = [[NSRelativeDateTimeFormatter alloc] init];
        rFormatter.unitsStyle = NSRelativeDateTimeFormatterUnitsStyleFull;
        NSLog(@"Norfolk RelativeDateTimeFormatter forward: %@", [rFormatter localizedStringForDate:finish relativeToDate:start]);
        NSLog(@"Norfolk RelativeDateTimeFormatter reversed: %@", [rFormatter localizedStringForDate:start relativeToDate:finish]);
        NSLog(@"Norfolk RelativeDateTimeFormatter zero: %@", [rFormatter localizedStringForDate:start relativeToDate:start]);

        // Europe/Dublin DST fall-back: 2024-10-27 01:59:30 IST -> 01:00:30 GMT
        NSTimeZone *dublin = [NSTimeZone timeZoneWithName:@"Europe/Dublin"];
        NSCalendar *dublinCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        dublinCal.timeZone = dublin;

        NSDateFormatter *iso = [[NSDateFormatter alloc] init];
        iso.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
        iso.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
        NSDate *dstart = [iso dateFromString:@"2024-10-27T00:59:30Z"];
        NSDate *dfinish = [dstart dateByAddingTimeInterval:60];

        NSLog(@"\nDublin start offset: %ld", (long)[dublin secondsFromGMTForDate:dstart]);
        NSLog(@"Dublin finish offset: %ld", (long)[dublin secondsFromGMTForDate:dfinish]);

        NSDateComponentsFormatter *dDcFormatter = [[NSDateComponentsFormatter alloc] init];
        dDcFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyleFull;
        dDcFormatter.allowedUnits = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
        dDcFormatter.calendar = dublinCal;
        NSLog(@"Dublin DateComponentsFormatter: %@", [dDcFormatter stringFromDate:dstart toDate:dfinish]);
        NSLog(@"Dublin DateComponentsFormatter reversed: %@", [dDcFormatter stringFromDate:dfinish toDate:dstart]);
        NSLog(@"Dublin DateComponentsFormatter zero: %@", [dDcFormatter stringFromDate:dstart toDate:dstart]);

        NSLog(@"Dublin RelativeDateTimeFormatter forward: %@", [rFormatter localizedStringForDate:dfinish relativeToDate:dstart]);
        NSLog(@"Dublin RelativeDateTimeFormatter reversed: %@", [rFormatter localizedStringForDate:dstart relativeToDate:dfinish]);
        NSLog(@"Dublin RelativeDateTimeFormatter zero: %@", [rFormatter localizedStringForDate:dstart relativeToDate:dstart]);
    }
    return 0;
}
