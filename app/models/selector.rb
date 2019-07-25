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
end
