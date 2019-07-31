class CoursesController < ApplicationController
  has_many :course_terms
  has_many :terms, through: :course_terms

  def index
    @courses = Course.all.where(course_type: 'class')
    render 'index.html.erb'
  end
end
