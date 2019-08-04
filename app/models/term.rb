class Term < ApplicationRecord
  belongs_to :user

  has_many :course_terms
  has_many :courses, through: :course_terms

  def semester_num_to_name
    case semester
    when 1 then 'fall'
    when 2 then 'interim'
    when 3 then 'spring'
    when 4 then 'summer session 1'
    when 5 then 'summer session 2'
    end
  end
end
