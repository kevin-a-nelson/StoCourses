class Course < ApplicationRecord
  has_many :course_classes, foreign_key: :lab_id, class_name: 'CourseLab'
  has_many :courses, through: :course_classes

  has_many :course_labs, foreign_key: :course_id, class_name: 'CourseLab'
  has_many :labs, through: :course_labs

  has_many :course_profs
  has_many :profs, through: :course_profs

  validates :clbid, uniqueness: true

  def dept_num_sec
    "#{department} #{number}#{section}"
  end

  def get_name
    name
  end

  def replaced_name
    name.include?('/') ? name.gsub('/', ' / ') : name
  end

  def dash_if_empty(attribute)
    attribute.to_s.length === 0 ? '---' : attribute
  end

  def rating_difference_reviews
    "#{rating_int} / #{difficulty_int} / #{num_reviews}"
  end

  def num_of_ges
    gereqs.split(', ').count
  end

  def description_or_none
    description.empty? ? 'none' : description
  end

  def prereqs_or_none
    prerequisites.empty? || prerequisites == 'f' ? 'none' : prerequisites
  end

  def notes_or_none
    notes.empty? ? 'none' : notes
  end

  def num_reviews
    profs[0] ? profs[0]['num_ratings'].to_f : 0
  end

  def difficulty_int
    profs[0] ? profs[0]['difficulty'].to_f : 0
  end

  def rating_int
    profs[0] ? profs[0]['rating'].to_f : 0
  end

  def rate_my_prof_url
    "https://www.ratemyprofessors.com/ShowRatings.jsp?tid=#{profs[0]['tid']}" if profs[0]
  end

  def has_prereqs
    prerequisites == ('f' || '') ? 'no' : 'yes'
  end

  def seats
    "#{enrolled} / #{max}"
  end
end
