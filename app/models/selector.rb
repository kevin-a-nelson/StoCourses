class Selector < ApplicationRecord
  def self.courses_with_department(courses, department)
    courses.select { |course| course['department'] == department }
  end

  def self.courses_with_keyword(courses, keyword)
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

  def self.courses_with_level(courses, level)
    courses.select do |course|
      course['level'] == level
    end
  end

  def self.courses_with_days(courses, days)
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

  def self.courses_with_gereqs(courses, input_gereqs)
    courses.select do |course|
      select_course = false
      next unless course['gereqs']

      course['gereqs'].each do |gereq|
        select_course = true if gereq == input_gereqs
        break
      end
      select_course
    end
  end
end
