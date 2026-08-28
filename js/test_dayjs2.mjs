process.env.TZ = 'Europe/Dublin';
import dayjs from 'dayjs';
import relativeTime from 'dayjs/plugin/relativeTime.js';
dayjs.extend(relativeTime);

const start = new Date(2024, 9, 27, 1, 59, 30);
const finish = new Date(start.getTime() + 60000);

console.log('dayjs:', dayjs(start).from(dayjs(finish)));
