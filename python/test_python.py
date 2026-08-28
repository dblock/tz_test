import os
os.environ['TZ'] = 'Pacific/Norfolk'
import time
time.tzset()

import humanize
from datetime import datetime
from zoneinfo import ZoneInfo

tz = ZoneInfo('Pacific/Norfolk')
start = datetime(2015, 1, 15, tzinfo=tz)
finish = datetime(2016, 3, 15, tzinfo=tz)

print("start utcoffset:", start.utcoffset())
print("finish utcoffset:", finish.utcoffset())
print("humanize naturaldelta:", humanize.naturaldelta(finish - start))
print("humanize precisedelta:", humanize.precisedelta(finish - start))

import arrow
a_start = arrow.get(start)
a_finish = arrow.get(finish)
print("arrow humanize:", a_start.humanize(a_finish))
