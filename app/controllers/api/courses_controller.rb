class Api::CoursesController < ApplicationController
  def index
    filtered_courses = []
    stolaf_courses = courses_data

    if params[:query]
      stolaf_courses.each do |course|
        filtered_courses << course[params[:query]]
      end
    end
    render json: { message: filtered_courses }
  end
end
