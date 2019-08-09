class Prof < ApplicationRecord
  validates :f_name, :l_name, :rating, :num_ratings, :tid, presence: true

  def courses
    Course.all.select { |course| course.instructors.match(name) }
  end
end
