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

    if params[:times]
      input_times = params[:times]
      @courses = @courses.select do |course|
        course['times'].include?(input_times)
      end
    end

    if params[:gereqs]
      input_gereqs = params[:gereqs]
      @courses = @courses.select do |course|
        course['gereqs'].include?(input_gereqs)
      end
    end

    if params[:name]
      input_name = params[:name]
      @courses = @courses.all.where(name: input_name)
    end

    if params[:instructors]
      input_instructors = params[:instructors]
      @courses = @courses.select do |course|
        course['instructors'].include?(input_instructors)
      end
    end

    render 'index.json.jb'
  end
end
