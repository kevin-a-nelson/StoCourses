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
sem_1_2019 = JSON.parse(response)

def course?(course)
  name = course['name'] || ''
  type = course['type'] || ''
  max = course['max'] || ''
  title = course['title'] || ''

  name = name.downcase
  title = title.downcase

  is_course = true

  is_course = false if name == 'academic internship'
  is_course = false if type == 'lab'
  is_course = false if max == (999 || 1)
  is_course = false if title == 'independent study'

  is_course
end

def create_course(course)
  new_course = course.new(
    credits: course['credits'],
    department: course['department'],
    description: course['description'],
    instructors: course['instructors'],
    enrolled: course['enrolled'],
    gereqs: course['gereqs'],
    level: course['level'],
    max: course['max'],
    name: course['name'],
    notes: course['notes'],
    number: course['number'],
    prerequisites: course['prerequisites'],
    section: course['section'],
    semester: course['semester'],
    status: course['status'],
    term: course['term'],
    year: course['year'],
    offerings: course['offerings']
  )
  new_course.save!
end

sem_1_2019.each do |section|
  create_course if course?(section) 
end
