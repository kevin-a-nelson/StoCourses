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
      courses = Selector.courses_with_department(courses, input_department)
    end

    if params[:keyword]
      input_keyword = params[:keyword]
      courses = Selector.courses_with_keyword(courses, input_keyword)
    end

    if params[:level]
      input_level = params[:level].to_i
      courses = Selector.courses_with_level(courses, input_level)
    end

    if params[:days]
      input_days = params[:days]
      courses = Selector.courses_with_days(courses, input_days)
    end

    if params[:gereqs]
      input_gereqs = params[:gereqs]
      courses = Selector.courses_with_gereqs(courses, input_gereqs)
    end

    render json: { count: courses.length, message: courses }
  end
end
