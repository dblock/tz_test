import moment from 'moment';
process.env.TZ = 'Pacific/Norfolk';

const start = moment(new Date(2015, 0, 15));
const finish = moment(new Date(2016, 2, 15));
console.log('Norfolk test (moment):', start.from(finish));
console.log('Norfolk duration (moment):', moment.duration(finish.diff(start)).humanize());
