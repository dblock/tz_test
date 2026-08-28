import humanize
import arrow
from datetime import datetime, timezone

a = datetime(2015, 1, 15, tzinfo=timezone.utc)
b = datetime(2016, 3, 15, tzinfo=timezone.utc)

print("--- reversed order (finish before start) ---")
print("humanize naturaldelta forward:", humanize.naturaldelta(b - a))
print("humanize naturaldelta reversed:", humanize.naturaldelta(a - b))
print("humanize precisedelta forward:", humanize.precisedelta(b - a))
print("humanize precisedelta reversed:", humanize.precisedelta(a - b))
print("arrow forward:", arrow.get(a).humanize(arrow.get(b)))
print("arrow reversed:", arrow.get(b).humanize(arrow.get(a)))

print("--- zero distance (same instant) ---")
print("humanize naturaldelta:", humanize.naturaldelta(a - a))
print("humanize precisedelta:", humanize.precisedelta(a - a))
print("arrow:", arrow.get(a).humanize(arrow.get(a)))
