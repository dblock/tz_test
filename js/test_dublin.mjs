process.env.TZ = 'Europe/Dublin';
import { formatDistance } from 'date-fns';
import dayjs from 'dayjs';
import moment from 'moment';

// Ireland's DST-like transition: clocks go back 1hr on last Sunday of October (like everywhere in EU)
// but Ireland's "winter" is technically the DST-offset in the tz database (inverted representation).
// Test a 1-minute gap that straddles a fall-back transition (2024-10-27 02:00 IST -> 01:00 GMT)
const start = new Date(2024, 9, 27, 1, 59, 30); // Oct 27 2024, 01:59:30 (ambiguous/near-transition)
const finish = new Date(start.getTime() + 60000); // + 1 minute

console.log('start:', start, start.getTimezoneOffset());
console.log('finish:', finish, finish.getTimezoneOffset());
console.log('date-fns:', formatDistance(start, finish, { includeSeconds: true }));
console.log('dayjs:', dayjs(start).from(dayjs(finish)));
console.log('moment:', moment(start).from(moment(finish)));
