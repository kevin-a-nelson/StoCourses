class ApplicationController < ActionController::Base
  # protect_from_forgery with: :null_session

  def courses_data
    file = File.read('stolaf_courses.json')
    data = JSON.parse(file)
    data_str = []
    data.each do |course|
      data_hash = {}
      course.each do |key, value|
        value = value.to_s
        value = value.gsub(/[\"\]\[\]]/, '')
        data_hash[key] = value
      end
      data_str << data_hash
    end
    data_str
    data
  end
end
