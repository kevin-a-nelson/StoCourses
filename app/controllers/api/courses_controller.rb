class Api::CoursesController < ApplicationController
  def index
    @courses = Course.all

    if params[:type]
      @courses = @courses.all.where(course_type: params[:type])
    end

    if params[:department]
      @courses = @courses.all.where(department: params[:department])
    end

    if params[:level]
      @courses = @courses.all.where(level: params[:level])
    end

    if params[:days]
      @courses = @courses.all.where(days: params[:days])
    end

    if params[:status]
      @courses = @courses.all.where(status: params[:status])
    end

    if params[:name]
      @courses = @courses.all.where(name: params[:name])
    end

    if params[:instructors]
      @courses = @courses.all.where(instructors: params[:instructors])
    end

    if params[:number]
      @courses = @courses.all.where(number: params[:number])
    end

    if params[:times]
      input_times = params[:times]
      @courses = @courses.select do |course|
        course[:times].include?(input_times)
      end
    end

    if params[:gereqs]
      input_gereqs = params[:gereqs]
      input_gereqs = input_gereqs.split('-')
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

  def show
    @course = Course.all.find_by_name(params['name'])
    @labs = @course.labs

    if @labs
      render 'show_labs.json.jb'
    else
      render 'show.json.jb'
    end
  end
end
