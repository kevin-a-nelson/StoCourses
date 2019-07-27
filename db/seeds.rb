# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'net/http'
require 'json'

url = 'https://stolaf.dev/course-data/terms/20191.json'
uri = URI(url)
response = Net::HTTP.get(uri)
stolaf_courses = JSON.parse(response)

def course?(course)
  name = course['name'] || ''
  type = course['type'] || ''
  max = course['max'] || ''
  title = course['title'] || ''

  name = name.downcase
  title = title.downcase

  is_course = true

  is_course = false if name.downcase == 'academic internship'
  is_course = false if type == 'lab'
  is_course = false if max == (999 || 1)
  is_course = false if title == 'independent study'

  is_course
end

stolaf_courses.each do |stolaf_course|
  next unless course?(stolaf_course)

  course = Course.new(
    credits: stolaf_course['credits'],
    department: stolaf_course['department'],
    description: stolaf_course['description'],
    instructors: stolaf_course['instructors'],
    enrolled: stolaf_course['enrolled'],
    gereqs: stolaf_course['gereqs'],
    level: stolaf_course['level'],
    max: stolaf_course['max'],
    name: stolaf_course['name'],
    notes: stolaf_course['notes'],
    number: stolaf_course['number'],
    prerequisites: stolaf_course['prerequisites'],
    section: stolaf_course['section'],
    semester: stolaf_course['semester'],
    status: stolaf_course['status'],
    term: stolaf_course['term'],
    year: stolaf_course['year'],
    offerings: stolaf_course['offerings']
  )
  course.save!
end
