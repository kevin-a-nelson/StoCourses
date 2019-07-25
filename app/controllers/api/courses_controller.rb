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
      courses = courses.select do |course|
        course['department'] == input_department
      end
    end

    if params[:keyword]
      input_keyword = params[:keyword]
      select_course = false
      courses = courses.select do |course|
        select_course = false
        course.each do |_key, value|
          value_str = value.to_s
          value_includes_input_keyword = value_str.match(input_keyword)
          if value_includes_input_keyword
            select_course = true
            break
          end
        end
        select_course
      end
    end

    if params[:level]
      input_level = params[:level].to_i
      courses = courses.select do |course|
        course['level'] == input_level
      end
    end

    render json: { count: courses.length, message: courses }
  end
end
