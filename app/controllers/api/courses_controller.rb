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

    if params[:status]
      input_status = params[:status]
      @courses = @courses.all.where(status: input_status)
    end

    if params[:times]
      input_times = params[:times]
      @courses = @courses.select do |course|
        course['times'].include?(input_times)
      end
    end

    if params[:name]
      input_name = params[:name]
      @courses = @courses.all.where(name: input_name)
    end

    if params[:instructors]
      input_instructors = params[:instructors]
      @courses = @courses.all.where(instructors: input_instructors)
    end

    if params[:gereqs]
      input_gereqs = params[:gereqs]
      input_gereqs = input_gereqs.split(',')
      @courses = @courses.select do |course|
        has_input_gereqs = true
        input_gereqs.each do |ge|
          unless course['gereqs'].include?(ge)
            has_input_gereqs = false
          end
        end
        has_input_gereqs
      end
    end

    render 'index.json.jb'
  end

  def course_labs
    # @course = Course.find_by_name("Struct Chem & Equilib")
    # @course = Course.all.where(clbid: params['clbid'])
    @course = Course.all.where(clbid: "0000124054")
    @course = @course.first
    render json: { labs: @course.labs }
  end
end
