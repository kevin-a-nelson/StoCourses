class Api::CoursesController < ApplicationController
  def index
    @courses = Course.all

    if params[:query]
      temp_courses = courses
      courses = []
      temp_courses.each do |course|
        next if course[params[:query]] == 'false'

        @courses << course[params[:query]]
      end
    end

    if params[:department]
      input_department = params[:department]
      @courses = @courses.all.where(department: input_department)
    end

    if params[:keyword]
      input_keyword = params[:keyword]
    end

    if params[:level]
      input_level = params[:level].to_i
      @courses = @courses.all.where(level: input_level)
    end

    if params[:days]
      input_days = params[:days]
      @courses = Selector.courses_with_days(@courses, input_days)
    end

    if params[:gereqs]
      input_gereqs = params[:gereqs]
      @courses = Selector.courses_with_gereqs(@courses, input_gereqs)
    end

    render json: { count: @courses.length, courses: @courses }
  end
end
