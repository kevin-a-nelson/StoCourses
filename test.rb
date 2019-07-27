require 'net/http'
require 'json'

url = 'https://stolaf.dev/course-data/terms/20183.json'
uri = URI(url)
response = Net::HTTP.get(uri)
stolaf_courses = JSON.parse(response)

all_durations = []
stolaf_courses.each do |course|
  offerings = course['offerings'].to_s.gsub(/[\"\[\]]/, '')
  starts = offerings.scan(/start=>(\w+:\w+)/)
  ends = offerings.scan(/end=>(\w+:\w+)/)
  duration = []
  starts.length.times do |idx|
  duration << "#{starts[idx]} - #{ends[idx]}".to_s.gsub(/[\"\]\[]/, '')
  end
  all_durations << duration
end

stolaf_courses.each do |course|
  offerings = course['offerings']
  if offerings
    # p course['name'] if offerings.length >= 4
    # p offerings if offerings.length > 4
  end
end

stolaf_courses.each do |course|
  offerings = course['offerings'].to_s.gsub(/[\"\[\]]/, '')
  offerings = offerings.scan(/location=>(\w+ \d+)/).uniq
  p course['name'] if offerings.length > 1
  # p offerings.scan(/location=>(\w+ \d+)/).uniq
end

all_durations.uniq.each do |time|
  # p time if time.length > 1
end

# offerings = '{day=>Tu, end=>13:10, location=>CHM Urness, start=>11:45}, {day=>Th, end=>14:05, location=>CHM Urness, start=>12:45}'

# offerings.scan(/day=>(\w+)/).join
# starts = offerings.scan(/start=>(\w+:\w+)/)
# ends = offerings.scan(/end=>(\w+:\w+)/)

# starts.length.times do |idx|
#   p "#{starts[idx]} - #{ends[idx]}".to_s.gsub(/[\"\]\[]/, '')
# end

# sample = 'The fat cat sat on the mat.'

# regex = sample.scan(/(at)/, /g/)

# p regex
