process.env.TZ = 'Europe/Dublin';
import moment from 'moment';

const start = new Date(2024, 9, 27, 1, 59, 30);
const finish = new Date(start.getTime() + 60000);

console.log('moment:', moment(start).from(moment(finish)));
console.log('moment duration:', moment.duration(moment(finish).diff(moment(start))).humanize());
