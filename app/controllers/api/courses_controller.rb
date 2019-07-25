class Api::CoursesController < ApplicationController
  def index
    courses = courses_data

    if params[:query]
      courses.each do |course|
        display_courses << course[params[:query]]
      end
    end

    if params[:department]
      input_department = params[:department]
      courses = Selector.courses_by_department(courses, input_department)
    end

    if params[:keyword]
      input_keyword = params[:keyword]
      courses = Selector.courses_by_keyword(courses, input_keyword)
    end

    if params[:level]
      input_level = params[:level].to_i
      courses = courses.select do |course|
        course['level'] == input_level
      end
    end

    if params[:days]
      input_days = params[:days]
      select_course = false
      courses = courses.select do |course|
        days_offered = ''
        select_course = false
        course.each do |key, value|
          if key == 'offerings'
            value.each do |offering|
              first_letter_of_day = offering['day'][0]
              days_offered += first_letter_of_day
            end
          end
        end
        select_course = true if days_offered == input_days
      end
      select_course
    end


    render json: { count: courses.length, message: courses }
  end
end
