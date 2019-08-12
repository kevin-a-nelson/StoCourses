class Course < ApplicationRecord
  has_many :course_classes, foreign_key: :lab_id, class_name: 'CourseLab'
  has_many :courses, through: :course_classes

  has_many :course_labs, foreign_key: :course_id, class_name: 'CourseLab'
  has_many :labs, through: :course_labs

  has_many :course_profs
  has_many :profs, through: :course_profs

  validates :clbid, uniqueness: true

  def index_elem_hash(attribute)
    attr_hash = {}
    split_attr = attribute.split(', ')
    split_attr.each.with_index do |value, i|
      attr_hash[i] = value
    end
    attr_hash
  end

  def dept_num_section
    {
      'dept': department,
      'num_sec': "#{number} #{section}"
    }
  end

  def formated_times
    return { '0': '---' } if times == ''

    index_elem_hash(times)
  end

  def pretty_name
    name.gsub('/', '/ ')
  end

  def num_of_ges
    gereqs.split(', ').count
  end

  def pretty_gereqs
    return { '0': '---' } if gereqs == ''

    gereqs_hash = {}
    gereqs.split(',').each.with_index do |ge, i|
      gereqs_hash[i] = ge
    end
    gereqs_hash
  end

  def pretty_instructors
    index_elem_hash(instructors)
  end

  def pretty_location
    return '---' if location == ''

    location.split(',').uniq[0]
  end

  def pretty_section
    section || ''
  end

  def pretty_days
    return '---' if days == ''

    days
  end

  def pretty_description
    return '---' if description == ''

    description
  end

  def pretty_notes
    return '---' if notes == ''

    notes
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
    return profs[0]['num_ratings'].to_i if profs[0] && profs[0]['num_ratings'] != 'N/A'

    0
  end

  def difficulty
    return profs[0]['difficulty'].to_f if profs[0] && profs[0]['difficulty'] != 'N/A'

    '--'
  end

  def rating
    return profs[0]['rating'].to_f if profs[0] && profs[0]['rating'] != 'N/A'

    '--'
  end

  def rate_my_prof_url
    return "https://www.ratemyprofessors.com/ShowRatings.jsp?tid=#{profs[0]['tid']}" if profs[0]

    '--'
  end

  def seats
    "#{enrolled} / #{max}"
  end
end
