class Course < ApplicationRecord
  has_many :course_labs
  has_many :labs, through: :course_labs

  def labs
    course_labs_ids = CourseLab.all.where(id: id)
    course_labs = Course.all.where(id: course_labs_ids)
  end
end
