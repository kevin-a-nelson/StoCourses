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
      @courses = @courses.map do |course|
        offerings = course['offerings'].to_s.gsub(/[\"\[\]]/, '')
        starts = offerings.scan(/start=>(\w+:\w+)/)
        ends = offerings.scan(/end=>(\w+:\w+)/)
        times = []

        starts.length.times do |idx|
          times << "#{starts[idx]} - #{ends[idx]}".to_s.gsub(/[\"\]\[]/, '')
        end

        times = times.uniq
        times = times.to_s.gsub(/[\"\[\]]/, '')
        days = offerings.scan(/day=>(\w+)/).to_s.gsub(/[\"\[\]]/, '')
        days = days.scan(/[A-Z]/).join

        if days == 'MWFT'
          days = 'MWFTh'
        end

        num_of_days = days.split(',').length
        # next if num_of_days != 1
        {
          course: course,
          days: days,
          times: times,
          schedule: "#{days} #{times}"
        }
      end
    end

    if params[:gereqs]
      input_gereqs = params[:gereqs]
      @courses = @courses.select do |course|
        course['gereqs'].include?(input_gereqs)
      end
    end

    render json: { count: @courses.length, courses: @courses }
  end
end
