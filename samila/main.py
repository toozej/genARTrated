from basic import basic
from projection import projection
from range import range
from color import color
from regeneration import regeneration

from datetime import datetime
# get current time
now = datetime.now()
# format timestamp for use in filenames
# example: 20211113-114001 for Nov 13th 2021 at 11:40:01
timestamp = now.strftime("%Y%m%d-%H%M%S")

basic(timestamp)
projection(timestamp)
range(timestamp)
color(timestamp)
regeneration(timestamp)
