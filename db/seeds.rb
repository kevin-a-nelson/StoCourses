require 'net/http'
require 'json'
require 'http'
require 'httparty'

def term_data(term)
  url = "https://stolaf.dev/course-data/terms/#{term}.json"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  JSON.parse(response)
end

# fall_2014 = term_data('20141')
# interim_2014 = term_data('20142')
# spring_2014 = term_data('20143')
# summer_first_2014 = term_data('20144')
# summer_second_2014 = term_data('20145')

# fall_2015 = term_data('20151')
# interim_2015 = term_data('20152')
# spring_2015 = term_data('20153')
# summer_first_2015 = term_data('20154')
# summer_second_2015 = term_data('20155')

# fall_2016 = term_data('20161')
# interim_2016 = term_data('20162')
# spring_2016 = term_data('20163')
# summer_first_2016 = term_data('20164')
# summer_second_2016 = term_data('20165')

# fall_2017 = term_data('20171')
# interim_2017 = term_data('20172')
# spring_2017 = term_data('20173')
# summer_first_2017 = term_data('20174')
# summer_second_2017 = term_data('20175')

# fall_2018 = term_data('20181')
# interim_2018 = term_data('20182')
# spring_2018 = term_data('20183')
# summer_first_2018 = term_data('20184')
# summer_second_2018 = term_data('20185')

# fall_2019 = term_data('20191')
# interim_2019 = term_data('20192')
# spring_2019 = term_data('20193')

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
    # p course['name']
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
end

# profs_data = JSON.parse(File.read("db/local_data/professors_data.json"))
def init_profs(profs_data)
  profs_data.each do |prof_data|
    prof_name = prof_data['name']
    middle_initial = prof_name.split(' ')[1]

    if prof_name.split(' ').length == 3
      prof_name = prof_name.gsub(/ \w /, " #{middle_initial}. ")
    end
    prof = Prof.new(
      num_ratings: prof_data['num_ratings'],
      name: prof_name,
      rating: prof_data['rating'],
      tid: prof_data['tid']
    )
    prof.save!
  end
end

def update_profs(profs_data)
  profs_data.each do |prof_data|
    Prof.all.each do |prof|
      next unless prof.tid == prof_data['tid']

      prof_name = prof_data['name']

      if prof_name.split(' ').length == 3
        middle_initial = prof_name.split(' ')[1]
        prof_name = prof_name.gsub(/ \w /, " #{middle_initial}. ")
      end

      prof.update(
        num_ratings: prof_data['num_ratings'] || prof.num_ratings,
        name: prof_name || prof.name,
        rating: prof_data['rating'] || prof.rating,
        tid: prof_data['tid'] || prof.tid
      )
    end
  end
end

def num_of_prof_pages
  url = "http://www.ratemyprofessors.com/filter/professor/?&page=1&filter=teacherlastname_sort_s+asc&query=*\%3A*&queryoption=TEACHER&queryBy=schoolId&sid=862"
  response = HTTParty.get(url)
  parsed_response = response.parsed_response
  search_results_total = parsed_response['searchResultsTotal']
  num_of_pages = search_results_total / 20
end

def profs_page_data(page)
  url = "http://www.ratemyprofessors.com/filter/professor/?&page=#{page}&filter=teacherlastname_sort_s+asc&query=*\%3A*&queryoption=TEACHER&queryBy=schoolId&sid=862"
  response = HTTParty.get(url)
  parsed_response = response.parsed_response
end

def scrape_difficulty(prof_id)
  url = "https://www.ratemyprofessors.com/ShowRatings.jsp?tid=#{prof_id}"
  response = HTTParty.get(url).body
  level_of_difficulty = response.match(/<div class="grade" title="">\s+(\d\.\d)/)

  if level_of_difficulty
    level_of_difficulty[1]
  else
    "N/A"
  end
end

def init_profs
  num_of_pages = num_of_prof_pages
  (1..num_of_pages).each do |page_num|
    page_data = profs_page_data(page_num)
    page_data = page_data['professors']
    page_data.each do |prof_data|
      sleep(0.5)
      difficulty = scrape_difficulty(prof_data['tid'])

      f_name = prof_data['tFname']
      f_name = f_name.gsub(/\s\(\w+\)/, '') if f_name.include?('(')

      prof = Prof.new(
        difficulty: difficulty,
        department: prof_data['tDept'],
        f_name: f_name,
        l_name: prof_data['tLname'],
        tid: prof_data['tid'],
        num_ratings: prof_data['tNumRatings'],
        rating: prof_data['overall_rating']
      )
      p prof.f_name
      prof.save!
    end
  end
end

def update_profs
  num_of_pages = num_of_prof_pages
  (1..num_of_pages).each do |page_num|
    puts page_num
    page_data = profs_page_data(page_num)
    page_profs_data = page_data['professors']
    page_profs_data.each do |prof_data|
      # puts 'prof JSON'
      sleep(0.5)
      Prof.all.each do |prof|
        next unless prof.tid == prof_data['tid']

        difficulty = scrape_difficulty(prof_data['tid'])

        f_name = prof_data['tFname']
        f_name = f_name.gsub(/\s\(\w+\)/, '') if f_name.include?('(')

        prof.update(
          difficulty: difficulty || prof.difficulty,
          department: prof_data['tDept'] || prof.department,
          f_name: f_name || prof.f_name,
          l_name: prof_data['tLname'] || prof.l_name,
          tid: prof_data['tid'] || prof.tid,
          num_ratings: prof_data['tNumRatings'] || prof.num_ratings,
          rating: prof_data['overall_rating'] || prof.rating
        )

        p "#{prof.f_name} #{prof.l_name}: #{prof.tid}"
      end
    end
  end
end

# init_profs
# update_profs

prof = Prof.second

puts prof.department

# prof.courses.each do |course|
  # puts "#{course.name}: #{course.department}"
  # puts "#{course.name}: #{course.instructors}"
# end

def write_in_file(file, content)
  file = File.open(file, "w")
  file.puts(content)
  file.close
end

# {
# 'tDept': 'Mathematics',
# 'tSid': '862',
# 'institution_name': 'St. Olaf College',
# 'tFname': 'Adam',
# 'tMiddlename': '',
# 'tLname': 'Berliner',
# 'tid': 1405645,
# 'tNumRatings': 16,
# 'rating_class': 'good',
# 'contentType': 'TEACHER',
# 'categoryType': 'PROFESSOR',
# 'overall_rating': '4.8'
# }

# init_term(summer_second_2017)
# link_courses_and_labs(20192)
# test_courses_and_labs_links(20192)
# update_courses(year: '2019', semester: '1')

# init_profs(profs_data)
# update_profs(profs_data)