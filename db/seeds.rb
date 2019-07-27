# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'net/http'
require 'json'

def term_data(year_and_semester_num)
  year = year_and_semester_num[:year]
  semester = year_and_semester_num[:semester]
  url = "https://stolaf.dev/course-data/terms/#{year + semester}.json"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  JSON.parse(response)
end

fall_2019 = term_data(year: '2019', semester: '1')
interim_2019 = term_data(year: '2019', semester: '2')
spring_2019 = term_data(year: '2019', semester: '3')

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

def course_times(offerings)
  start_times = offerings.scan(/start=>(\w+:\w+)/)
  end_times = offerings.scan(/end=>(\w+:\w+)/)
  full_times = []

  start_times.length.times do |idx|
    full_times << "#{start_times[idx]} - #{end_times[idx]}".to_s.gsub(/[\"\]\[]/, '')
  end

  array_to_str(full_times)
end

def course_days(offerings)
  days_arr = offerings.scan(/day=>(\w+)/)
  arr_to_str(days_arr)
end

def open_to_cohort?(cohort)
  !cohort.match('/0')
end

def course_location(offerings)
  location_arr = offerings.scan(/location=>(\w+\s\d+)/)
  array_to_str(location_arr)
end

def arr_to_str(arr)
  arr = arr.to_s
  att.gsub(/[\"\[\]]/)
end

def hash_to_str(hsh)
  hsh = hsh.to_s
  hsh.gsub(/[\"\[\]]/)
end

def create_course(course)
  offerings = hash_to_str(course['offerings'])

  times_str = course_times(offerings)
  days_str = course_times(offerings)
  location_str = course_location(course['offerings'])

  open_to_firstyear = open_to_cohort(course['firstyear'])
  open_to_sophmore = open_to_cohort(course['sophmore'])
  open_to_junior = open_to_cohort(course['junior'])
  open_to_senior = open_to_cohort(course['senior'])

  description_str = arr_to_str(course['description'])
  instructors_str = arr_to_str(course['instructors'])
  notes_str       = arr_to_str(course['notes'])
  gereqs_str      = arr_to_str(course['gereqs'])

  revisions = hash_to_str(course['revisions'])

  new_course = course.new(
    clbid: course['clbid'],
    credits: course['credits'],
    crsid: course['crsid'],
    department: course['department'],
    description: description_str,
    enrolled: course['enrolled'],
    gereqs: gereqs_str,
    instructors: instructors_str,
    level: course['level'],
    max: course['max'],
    name: course['name'],
    notes: notes_str,
    number: course['number'],
    offerings: offerings_str,
    pn: course['pn'],
    prerequisites: course['prerequisites'],
    revisions: revisions,
    section: course['section'],
    semester: course['semester'],
    status: course['status'],
    term: course['term'],
    type: course['type'],
    year: course['year'],
    days: days_str,
    times: times_str,
    location: location_str,
    firstyear: open_to_firstyear,
    sophmore: open_to_sophmore,
    junior: open_to_junior,
    senior: open_to_senior
  )
  new_course.save!
end

fall_2019.each do |section|
  create_course if course?(section)
end
