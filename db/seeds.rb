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

stolaf_courses.each do |stolaf_course|
  next if stolaf_course['name'].downcase == 'academic internship'
  next if stolaf_course['type'].downcase == 'lab'
  next if stolaf_course['max'] == 999
  next if stolaf_course['max'] == 1

  if stolaf_course['title']
    next if stolaf_course['title'].downcase == 'independent study'
  end

  course = Course.new(
    credits: stolaf_course['credits'],
    department: stolaf_course['department'],
    description: stolaf_course['description'].to_s.gsub(/[\"\[\]]/, ''),
    instructors: stolaf_course['instructors'].to_s.gsub(/[\"\[\]]/, ''),
    enrolled: stolaf_course['enrolled'],
    gereqs: stolaf_course['gereqs'].to_s.gsub(/[\"\[\]]/, ''),
    level: stolaf_course['level'],
    max: stolaf_course['max'],
    name: stolaf_course['name'],
    notes: stolaf_course['notes'].to_s.gsub(/[\"\[\]]/, ''),
    number: stolaf_course['number'],
    prerequisites: stolaf_course['prerequisites'],
    section: stolaf_course['section'],
    semester: stolaf_course['semester'],
    status: stolaf_course['status'],
    term: stolaf_course['term'],
    year: stolaf_course['year'],
    offerings: stolaf_course['offerings'].to_s.gsub(/[\"\[\]]/, '')
  )
  course.save!
end
