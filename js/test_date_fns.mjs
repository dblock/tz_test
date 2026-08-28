import { formatDistance } from 'date-fns';

process.env.TZ = 'Pacific/Norfolk';

const start = new Date(2015, 0, 15); // local time construction
const finish = new Date(2016, 2, 15);
console.log('start offset (min):', start.getTimezoneOffset());
console.log('finish offset (min):', finish.getTimezoneOffset());
console.log('Norfolk test (date-fns):', formatDistance(start, finish, { includeSeconds: true }));
