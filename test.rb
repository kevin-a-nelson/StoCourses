require 'net/http'
require 'json'

url = 'https://stolaf.dev/course-data/terms/20183.json'
uri = URI(url)
response = Net::HTTP.get(uri)
stolaf_courses = JSON.parse(response)

course = stolaf_courses[0]

offerings = course['offerings'].to_s.gsub(/[\"\[\]]/, '')
days_arr = offerings.scan(/day=>(\w+)/)
temp_days_arr = days_arr
days_arr = []
temp_days_arr.each do |day|
  days_arr << day[0]
end

p days_arr
