require 'json'

file = File.read('stolaf_courses.json')
data = JSON.parse(file)
puts data