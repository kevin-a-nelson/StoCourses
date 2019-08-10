class Course < ApplicationRecord
  has_many :course_classes, foreign_key: :lab_id, class_name: 'CourseLab'
  has_many :courses, through: :course_classes

  has_many :course_labs, foreign_key: :course_id, class_name: 'CourseLab'
  has_many :labs, through: :course_labs

  has_many :course_profs
  has_many :profs, through: :course_profs

  validates :clbid, uniqueness: true

  def formated_times
    times.gsub(/\s/, '').split(',').uniq.to_s.gsub(/[\"\[\]]/, '').gsub('-', ' - ')
  end

  def num_of_ges
    gereqs.split(", ").count
  end

  def semester_num_to_name
    case semester
    when 1 then 'fall'
    when 2 then 'interim'
    when 3 then 'spring'
    when 4 then 'summer session 1'
    when 5 then 'summer session 2'
    end
  end

  def num_ratings
    return profs[0]['num_ratings'] if profs[0]
    'N/A'
  end

  def difficulty
    return profs[0]['difficulty'] if profs[0]
    'N/A'
  end

  def rating
    return profs[0]['rating'] if profs[0]
    'N/A'
  end

  def rate_my_prof_url
    return "https://www.ratemyprofessors.com/ShowRatings.jsp?tid=#{profs[0]['tid']}" if profs[0]
    'N/A'
  end
end
