class CoursesController < ApplicationController
  def index
    @courses = Course.all.where(course_type: 'class')
    render 'index.html.erb'
  end
end
