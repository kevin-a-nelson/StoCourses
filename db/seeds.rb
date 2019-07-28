# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'net/http'
require 'json'

def term_data(year_and_semester)
  year = year_and_semester[:year]
  semester = year_and_semester[:semester]
  url = "https://stolaf.dev/course-data/terms/#{year + semester}.json"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  JSON.parse(response)
end

fall_2019 = term_data(year: '2019', semester: '1')

def arr_to_clean_str(arr)
  arr = arr.to_s
  arr.gsub(/[\"\[\]\\]/, '')
end

def hash_to_clean_str(hsh)
  hsh = hsh.to_s
  hsh.gsub(/[\"\[\]\\]/, '')
end

def course_times(offerings)
  start_times = offerings.scan(/start=>(\w+:\w+)/)
  end_times = offerings.scan(/end=>(\w+:\w+)/)
  full_times = []

  start_times.length.times do |idx|
    full_time = "#{start_times[idx]}-#{end_times[idx]}"
    full_times << full_time
  end

  arr_to_clean_str(full_times)
end

def course_days(offerings)
  days_arr = offerings.scan(/day=>(\w+)/)
  return '' unless days_arr

  temp_days_arr = days_arr
  days_arr = []
  temp_days_arr.each do |day|
    days_arr << day[0]
  end

  days_acroynm = []
  days_arr.each do |day|
    day = day.downcase
    if day == 'mo'
      days_acroynm << 'M'
    elsif day == 'tu'
      days_acroynm << 'Tu'
    elsif day == 'we'
      days_acroynm << 'W'
    elsif day == 'th'
      days_acroynm << 'Th'
    elsif day == 'fr'
      days_acroynm << 'F'
    end
  end

  days_acroynm_str = ''

  days_acroynm_sorted = (%w[M Tu W Th F] & days_acroynm)

  days_acroynm_str = 'MWF' if days_acroynm_sorted == %w[M W F]
  days_acroynm_str = 'TTh' if days_acroynm_sorted == %w[Tu Th]
  days_acroynm_str = 'M-F' if days_acroynm_sorted == %w[M Tu W Th F]

  if days_acroynm_str == ''
    days_acroynm_sorted.each do |acronym|
      days_acroynm_str += acronym
    end
  end

  days_acroynm_str = 'MWF-Th' if days_acroynm_str == 'MWThF'
  days_acroynm_str = 'MWF-Tu' if days_acroynm_str == 'MTuWF'

  days_acroynm_str
end

def course_location(offerings)
  location_arr = offerings.scan(/location=>(\w+\s\d+)/)
  arr_to_clean_str(location_arr)
end

def get_course_type(course)
  type = course_attribute_downcase(course, 'type')
  name = course_attribute_downcase(course, 'name')
  title = course_attribute_downcase(course, 'title')

  lab_in_type = type.match('lab')

  academic_internship_in_name = name.match('academic internship')
  academic_internship_in_title = title.match('academic internship')

  independent_research_in_name = name.match('independent research')
  independent_research_in_title = title.match('independent research')

  independent_study_in_name = name.match('is/')
  independent_study_in_title = title.match('independent study')

  course_type = if lab_in_type
                  'lab'
                elsif academic_internship_in_name || academic_internship_in_title
                  'academic internship'
                elsif independent_research_in_name || independent_research_in_title
                  'independent research'
                elsif independent_study_in_name || independent_study_in_title
                  'independent study'
                else
                  'class'
                end
  course_type
end

def create_course(course)
  offerings_str = hash_to_clean_str(course['offerings'])

  times_str = course_times(offerings_str)
  days_str = course_days(offerings_str)
  location_str = course_location(offerings_str)

  open_to_firstyear = true
  open_to_sophmore = true
  open_to_junior = true
  open_to_senior = true

  description_str = arr_to_clean_str(course['description'])
  instructors_str = arr_to_clean_str(course['instructors'])
  notes_str       = arr_to_clean_str(course['notes'])
  gereqs_str      = arr_to_clean_str(course['gereqs'])

  revisions = hash_to_clean_str(course['revisions'])

  course_type = get_course_type(course)

  new_course = Course.new(
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
    course_type: course_type,
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

def course_attribute_downcase(course, attribute)
  attribute = course[attribute] || attribute
  attribute.downcase
end

fall_2019.each do |course|
  create_course(course)
end
