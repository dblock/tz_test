import os
os.environ['TZ'] = 'Europe/Dublin'
import time
time.tzset()

import humanize
from datetime import datetime, timedelta
from zoneinfo import ZoneInfo

tz = ZoneInfo('Europe/Dublin')
start = datetime(2024, 10, 27, 1, 59, 30, tzinfo=tz)
finish = start + timedelta(minutes=1)

print("start utcoffset:", start.utcoffset(), start.dst())
print("finish utcoffset:", finish.utcoffset(), finish.dst())
print("humanize naturaldelta:", humanize.naturaldelta(finish - start))

import arrow
print("arrow humanize:", arrow.get(start).humanize(arrow.get(finish)))
