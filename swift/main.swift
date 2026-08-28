import Foundation

func testCase(_ label: String, _ start: Date, _ finish: Date, tzID: String) {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    let calendar = Calendar.current
    print("\(label) RelativeDateTimeFormatter forward: \(formatter.localizedString(for: finish, relativeTo: start))")
    print("\(label) RelativeDateTimeFormatter reversed: \(formatter.localizedString(for: start, relativeTo: finish))")
    print("\(label) RelativeDateTimeFormatter zero: \(formatter.localizedString(for: start, relativeTo: start))")
}

// Norfolk Island permanent offset change: +11:30 -> +11:00 on 2015-10-04
var cal = Calendar(identifier: .gregorian)
cal.timeZone = TimeZone(identifier: "Pacific/Norfolk")!
var startComps = DateComponents(year: 2015, month: 1, day: 15, hour: 0, minute: 0, second: 0)
var finishComps = DateComponents(year: 2016, month: 3, day: 15, hour: 0, minute: 0, second: 0)
let start = cal.date(from: startComps)!
let finish = cal.date(from: finishComps)!

print("Norfolk start offset: \(cal.timeZone.secondsFromGMT(for: start))")
print("Norfolk finish offset: \(cal.timeZone.secondsFromGMT(for: finish))")

// NSDateComponentsFormatter compound breakdown, using the timezone-aware calendar
let dcFormatter = DateComponentsFormatter()
dcFormatter.unitsStyle = .full
dcFormatter.allowedUnits = [.year, .month, .day, .hour, .minute]
dcFormatter.calendar = cal
print("Norfolk DateComponentsFormatter: \(dcFormatter.string(from: start, to: finish) ?? "nil")")
print("Norfolk DateComponentsFormatter reversed: \(dcFormatter.string(from: finish, to: start) ?? "nil")")

testCase("Norfolk", start, finish, tzID: "Pacific/Norfolk")

// Dublin DST fall-back transition: 2024-10-27 01:59:30 IST -> 01:00:30 GMT one minute later
var dublinCal = Calendar(identifier: .gregorian)
dublinCal.timeZone = TimeZone(identifier: "Europe/Dublin")!
let dstartUTC = ISO8601DateFormatter().date(from: "2024-10-27T00:59:30Z")!
let dfinishUTC = dstartUTC.addingTimeInterval(60)

print("\nDublin start offset: \(dublinCal.timeZone.secondsFromGMT(for: dstartUTC))")
print("Dublin finish offset: \(dublinCal.timeZone.secondsFromGMT(for: dfinishUTC))")

let dDcFormatter = DateComponentsFormatter()
dDcFormatter.unitsStyle = .full
dDcFormatter.allowedUnits = [.year, .month, .day, .hour, .minute]
dDcFormatter.calendar = dublinCal
print("Dublin DateComponentsFormatter: \(dDcFormatter.string(from: dstartUTC, to: dfinishUTC) ?? "nil")")

testCase("Dublin", dstartUTC, dfinishUTC, tzID: "Europe/Dublin")
