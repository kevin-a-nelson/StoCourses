require 'json'

class Course
  def initialize(course_data)
    @credits = course_data['credits']
    @department = course_data['department']
    @instructors = course_data['instructors'].to_s.gsub(/[\"\[\]]/, '')
    @level = course_data['level']
    @max = course_data['max']
    @name = course_data['name']
    @notes = course_data['notes'].to_s.gsub(/[\"\[\]]/, '')
    @number = course_data['number']
    @prerequisites = course_data['prerequisites']
    @semester = course_data['semester']
    @term = course_data['term']
    @type = course_data['type']
    @year = course_data['year']
  end

  def printValues
    p "Credits: #{@credits}"
    p "department: #{@department}"
    p "instructors: #{@instructors}"
    p "level: #{@level}"
    p "max: #{@max}"
    p "name: #{@name}"
    p "notes: #{@notes}"
    p "number: #{@number}"
    p "prerequisites: #{@prerequisites}"
    p "semester: #{@semester}"
    p "term: #{@term}"
    p "type: #{@type}"
    p "year: #{@year}"
  end
end

# "credits": "1",
file = File.read('stolaf_courses.json')
data = JSON.parse(file)

10.times do |num|
  Course.new(data[num]).printValues
  puts '================================='
end

# "department": "HIST",
# "enrolled": "0",
# "instructors": "Staff",
# "level": "200",
# "max": "999",
# "name": "Academic Internship",
# "notes": "Please see Piper Center's academic internship website to access Handshake to, fill out the necessary information to register for this class.",
# "number": "294",

# "prerequisites": "false",

# "semester": "1",
# "status": "C",
# "term": "20191",
# "type": "Research",
# "year": "2019"
