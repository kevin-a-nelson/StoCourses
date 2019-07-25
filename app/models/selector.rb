class Selector < ApplicationRecord

  def self.courses_by_department(courses, department)
    courses.select { |course| course['department'] == department }
  end

  def self.courses_by_keyword(courses, keyword)
    select_course = false
    courses.select do |course|
      select_course = false
      course.each do |_key, value|
        value_str = value.to_s
        value_has_keyword = value_str.match(keyword)
        if value_has_keyword
          select_course = true
          break
        end
      end
      select_course
    end
  end

  def self.courses_by_level(courses, level)
    courses.select do |course|
      course['level'] == level
    end
  end

  def self.courses_by_days(courses, days)
    select_course = false
    courses.select do |course|
      days_offered = ''
      select_course = false
      course.each do |key, value|
        next unless key == 'offerings'

        value.each do |offering|
          first_letter_of_day = offering['day'][0]
          days_offered += first_letter_of_day
        end
      end
      select_course = true if days_offered == days
    end
  end
end
