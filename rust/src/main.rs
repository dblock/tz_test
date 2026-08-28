use chrono::{TimeZone, Duration};
use chrono_tz::Pacific::Norfolk;
use chrono_tz::Europe::Dublin;
use chrono_humanize::HumanTime;

fn main() {
    // Norfolk Island permanent offset change
    let start = Norfolk.with_ymd_and_hms(2015, 1, 15, 0, 0, 0).unwrap();
    let finish = Norfolk.with_ymd_and_hms(2016, 3, 15, 0, 0, 0).unwrap();
    println!("start offset: {:?}", start.offset());
    println!("finish offset: {:?}", finish.offset());
    let diff = finish.signed_duration_since(start);
    println!("Norfolk raw diff: {} seconds ({} days)", diff.num_seconds(), diff.num_days());
    println!("Norfolk HumanTime: {}", HumanTime::from(diff));

    // Dublin DST transition (ambiguous local time; pick the earlier/IST occurrence)
    let dstart = Dublin.with_ymd_and_hms(2024, 10, 27, 1, 59, 30).earliest().unwrap();
    let dfinish = dstart + Duration::minutes(1);
    println!("Dublin start offset: {:?}", dstart.offset());
    println!("Dublin finish offset: {:?}", dfinish.offset());
    let ddiff = dfinish.signed_duration_since(dstart);
    println!("Dublin raw diff: {} seconds", ddiff.num_seconds());
    println!("Dublin HumanTime: {}", HumanTime::from(ddiff));
}
