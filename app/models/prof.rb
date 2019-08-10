class Prof < ApplicationRecord
  validates :f_name, :l_name, :rating, :num_ratings, :tid, presence: true
  validates :tid, uniqueness: true

  has_many :course_profs
  has_many :courses, through: :course_profs

  def link_to_courses
    Course.all.each do |course|
      if course.instructors.match(f_name) && course.instructors.match(l_name)
        course_prof = CourseProf.new(
          prof_id: id,
          course_id: course.id
        )
        course_prof.save!
        puts "Match! #{id} : #{course.id}"
      end
    end
  end
end
