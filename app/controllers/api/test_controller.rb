class Api::TestController < ApplicationController
  def index
    @missing_profs = []
    courses = Course.where(term: 20191)

    courses.all.each do |course|
      prof_found = false
      Prof.all.each do |prof|
        if course.instructors.match(prof.name)
          prof_found = true
          break
        end
      end

      @missing_profs << course.instructors if !prof_found
    end

    @missing_profs = @missing_profs.uniq.count
    @missing_profs = Prof.count
    
    render 'index.json.jb'
  end
end
