import dayjs from 'dayjs';
import relativeTime from 'dayjs/plugin/relativeTime.js';
dayjs.extend(relativeTime);

process.env.TZ = 'Pacific/Norfolk';

const start = new Date(2015, 0, 15);
const finish = new Date(2016, 2, 15);
console.log('start offset (min):', start.getTimezoneOffset());
console.log('finish offset (min):', finish.getTimezoneOffset());
console.log('Norfolk test (dayjs):', dayjs(start).from(dayjs(finish)));
console.log('Norfolk diff (dayjs, days):', dayjs(finish).diff(dayjs(start), 'day'));
console.log('Norfolk diff (dayjs, hours remainder):', dayjs(finish).diff(dayjs(start), 'hour') % 24);
