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

fall_2014 = term_data(year: '2014', semester: '1')
interim_2014 = term_data(year: '2014', semester: '2')
spring_2014 = term_data(year: '2014', semester: '3')
summer_first_2014 = term_data(year: '2014', semester: '4')
summer_second_2014 = term_data(year: '2014', semester: '5')

fall_2015 = term_data(year: '2015', semester: '1')
interim_2015 = term_data(year: '2015', semester: '2')
spring_2015 = term_data(year: '2015', semester: '3')
summer_first_2015 = term_data(year: '2015', semester: '4')
summer_second_2015 = term_data(year: '2015', semester: '5')

fall_2016 = term_data(year: '2016', semester: '1')
interim_2016 = term_data(year: '2016', semester: '2')
spring_2016 = term_data(year: '2016', semester: '3')
summer_first_2016 = term_data(year: '2016', semester: '4')
summer_second_2016 = term_data(year: '2016', semester: '5')

fall_2017 = term_data(year: '2017', semester: '1')
interim_2017 = term_data(year: '2017', semester: '2')
spring_2017 = term_data(year: '2017', semester: '3')
summer_first_2017 = term_data(year: '2017', semester: '4')
summer_second_2017 = term_data(year: '2017', semester: '5')

fall_2018 = term_data(year: '2018', semester: '1')
interim_2018 = term_data(year: '2018', semester: '2')
spring_2018 = term_data(year: '2018', semester: '3')
summer_first_2018 = term_data(year: '2018', semester: '4')
summer_second_2018 = term_data(year: '2018', semester: '5')

fall_2019 = term_data(year: '2019', semester: '1')
interim_2019 = term_data(year: '2019', semester: '2')
spring_2019 = term_data(year: '2019', semester: '3')

# Not yet available

# summer_first_2019 = term_data(year: '2019', semester: '4')
# summer_second_2019 = term_data(year: '2019', semester: '5')

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

  full_times = full_times.uniq

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

def course_attribute_downcase(course, attribute)
  attribute = course[attribute] || attribute
  attribute.downcase
end

def get_course_type(course)
  type = course_attribute_downcase(course, 'type')
  name = course_attribute_downcase(course, 'name')
  title = course_attribute_downcase(course, 'title')

  lab_in_type = type.match('lab')

  academic_internship_in_name = name.match('academic internship')
  academic_internship_in_title = title.match('academic internship')

  independent_research_in_name = name.match('independent research') || name.match('ir/')
  independent_research_in_title = title.match('independent research')

  independent_study_in_name = name.match('is/') || name.match('independent study')
  independent_study_in_title = title.match('independent study')

  course_type = if lab_in_type
                  'lab'
                elsif academic_internship_in_name || academic_internship_in_title
                  'AI'
                elsif independent_research_in_name || independent_research_in_title
                  'IR'
                elsif independent_study_in_name || independent_study_in_title
                  'IS'
                else
                  'class'
                end
  course_type
end

def parse_course(course)
  offerings_str = hash_to_clean_str(course['offerings'])

  times_str = course_times(offerings_str)
  days_str = course_days(offerings_str)
  location_str = course_location(offerings_str)

  description_str = arr_to_clean_str(course['description'])
  instructors_str = arr_to_clean_str(course['instructors'])
  notes_str       = arr_to_clean_str(course['notes'])
  gereqs_str      = arr_to_clean_str(course['gereqs'])

  revisions = hash_to_clean_str(course['revisions'])

  course_type = get_course_type(course)

  parsed_course = {
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
    location: location_str
  }
  parsed_course
end

def create_course(course)
  parsed_course = parse_course(course)
  new_course = Course.new(
    clbid: parsed_course[:clbid],
    credits: parsed_course[:credits],
    crsid: parsed_course[:crsid],
    department: parsed_course[:department],
    description: parsed_course[:description],
    enrolled: parsed_course[:enrolled],
    gereqs: parsed_course[:gereqs],
    instructors: parsed_course[:instructors],
    level: parsed_course[:level],
    max: parsed_course[:max],
    name: parsed_course[:name],
    notes: parsed_course[:notes],
    number: parsed_course[:number],
    offerings: parsed_course[:offerings],
    pn: parsed_course[:pn],
    prerequisites: parsed_course[:prerequisites],
    revisions: parsed_course[:revisions],
    section: parsed_course[:section],
    semester: parsed_course[:semester],
    status: parsed_course[:status],
    term: parsed_course[:term],
    course_type: parsed_course[:course_type],
    year: parsed_course[:year],
    days: parsed_course[:days],
    times: parsed_course[:times],
    location: parsed_course[:location]
  )
  new_course.save!
end

def update_courses(year_and_semester)
  api_courses = term_data(year_and_semester)

  api_courses.each do |api_course|
    clsid = api_course['clbid']
    db_course = Course.all.where(clbid: clsid).limit(1)

    if !db_course.empty?
      api_course = parse_course(api_course)
      update_course(db_course, api_course)
    else
      create_course(api_course)
    end
  end
end

def update_course(course, updated_course)
  course.update(
    clbid: updated_course[:clbid],
    credits: updated_course[:credits],
    crsid: updated_course[:crsid],
    department: updated_course[:department],
    description: updated_course[:description],
    enrolled: updated_course[:enrolled],
    gereqs: updated_course[:gereqs],
    instructors: updated_course[:instructors],
    level: updated_course[:level],
    max: updated_course[:max],
    name: updated_course[:name],
    notes: updated_course[:notes],
    number: updated_course[:number],
    offerings: updated_course[:offerings],
    pn: updated_course[:pn],
    prerequisites: updated_course[:prerequisites],
    revisions: updated_course[:revisions],
    section: updated_course[:section],
    semester: updated_course[:semester],
    status: updated_course[:status],
    term: updated_course[:term],
    course_type: updated_course[:course_type],
    year: updated_course[:year],
    days: updated_course[:days],
    times: updated_course[:times],
    location: updated_course[:location]
  )
end

def init_term(term)
  term.each do |course|
    p course['name']
    create_course(course)
  end
end

### Linking Labs to Courses ###

def link_courses_and_labs(term)
  labs = Course.where(course_type: 'lab').where(term: term)
  courses = Course.where(term: term)
  courses.all.each do |course|
    labs.each do |lab|
      next if course['name'] == lab['name']

      if lab['name'].include?(course['name']) && lab['name'].include?('Lab')
        CourseLab.create(course_id: course.id, lab_id: lab.id)
        next
      end

      next if course['department'] != lab['department']
      next if course['number'] != lab['number']
      CourseLab.create(course_id: course.id, lab_id: lab.id)
    end
  end
end

def test_courses_and_labs_links(term)
  course_and_labs = []
  courses = Course.where(term: term)
  courses.all.each do |course|
    if course.labs
      course.labs.each do |lab|
        course_and_labs << "#{course['name']} -- #{lab['name']}"
      end
    end
  end
  course_and_labs = course_and_labs.uniq
  puts course_and_labs
  puts course_and_labs.count
end

# init_term(summer_first_2018)
# link_courses_and_labs(20192)
# test_courses_and_labs_links(20192)
update_courses(year: '2019', semester: '1')
