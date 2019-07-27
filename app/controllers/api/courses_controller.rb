class Api::CoursesController < ApplicationController
  def index
    @courses = Course.all

    if params[:type]
      input_type = params[:type]
      @courses = @courses.all.where(course_type: input_type)
    end

    if params[:department]
      input_department = params[:department]
      @courses = @courses.all.where(department: input_department)
    end

    if params[:level]
      input_level = params[:level].to_i
      @courses = @courses.all.where(level: input_level)
    end

    if params[:days]
      input_days = params[:days]
      @courses = @courses.all.where(days: input_days)
    end

    if params[:gereqs]
      input_gereqs = params[:gereqs]
      @courses = @courses.select do |course|
        course['gereqs'].include?(input_gereqs)
      end
    end

    render 'index.json.jb'
  end
end
