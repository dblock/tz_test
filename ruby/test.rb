# frozen_string_literal: true

require 'bundler/setup'
require 'active_support/all'
require 'tzinfo'
require 'tzinfo/data'
require 'dotiw'

include DOTIW::Methods

def show(label, from_time, to_time)
  puts "#{label}: #{distance_of_time_in_words(from_time, to_time)}"
end

# Norfolk Island permanent offset change: +11:30 -> +11:00 on 2015-10-04
norfolk = ActiveSupport::TimeZone['Pacific/Norfolk']
start = norfolk.local(2015, 1, 15)
finish = norfolk.local(2016, 3, 15)

puts "Norfolk start offset: #{start.utc_offset}"
puts "Norfolk finish offset: #{finish.utc_offset}"
show('Norfolk forward', start, finish)
show('Norfolk reversed', finish, start)
show('Norfolk zero', start, start)

# Europe/Dublin DST fall-back: 2024-10-27 01:59:30 IST -> 01:00:30 GMT one minute later
dublin = ActiveSupport::TimeZone['Europe/Dublin']
dstart = Time.utc(2024, 10, 27, 0, 59, 30).in_time_zone(dublin)
dfinish = dstart + 60

puts "\nDublin start offset: #{dstart.utc_offset}"
puts "Dublin finish offset: #{dfinish.utc_offset}"
show('Dublin forward', dstart, dfinish)
show('Dublin reversed', dfinish, dstart)
show('Dublin zero', dstart, dstart)
