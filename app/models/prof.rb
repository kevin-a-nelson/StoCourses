class Prof < ApplicationRecord
  validates :f_name, :l_name, :rating, :num_ratings, :tid, presence: true
  validates :tid, uniqueness: true

  # has_many :course_profs
  # has_many :courses, through: :course_prof

  def courses
    Course.all.select do |course|
      course.instructors.match(f_name) && course.instructors.match(l_name)
    end
  end
end
