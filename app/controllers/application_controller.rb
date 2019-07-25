class ApplicationController < ActionController::Base
  # protect_from_forgery with: :null_session

  def courses_data
    file = File.read('stolaf_courses.json')
    data = JSON.parse(file)
    data
  end
end
