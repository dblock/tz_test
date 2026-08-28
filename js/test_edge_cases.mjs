import { formatDistance } from 'date-fns';
import dayjs from 'dayjs';
import relativeTime from 'dayjs/plugin/relativeTime.js';
import moment from 'moment';

dayjs.extend(relativeTime);

const a = new Date('2015-01-15T00:00:00Z');
const b = new Date('2016-03-15T00:00:00Z');

console.log('--- reversed order (finish before start) ---');
console.log('date-fns forward:', formatDistance(b, a));
console.log('date-fns reversed:', formatDistance(a, b));
console.log('dayjs forward:', dayjs(a).from(dayjs(b)));
console.log('dayjs reversed:', dayjs(b).from(dayjs(a)));
console.log('moment forward:', moment(a).from(moment(b)));
console.log('moment reversed:', moment(b).from(moment(a)));

console.log('--- zero distance (same instant) ---');
console.log('date-fns:', formatDistance(a, a));
console.log('dayjs:', dayjs(a).from(dayjs(a)));
console.log('moment:', moment(a).from(moment(a)));
