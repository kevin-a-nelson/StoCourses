class Api::CoursesController < ApplicationController
  def index
    @courses = Course.all

    if params[:term]
      @courses = @courses.where(term: params[:term])
    end

    if params[:year]
      @courses = @courses.where(year: params[:year])
    end

    if params[:semester]
      @courses = @courses.where(semester: params[:semester])
    end

    if params[:type]
      @courses = @courses.where(course_type: params[:type])
    end

    if params[:department]
      @courses = @courses.where(department: params[:department])
    end

    if params[:level]
      @courses = @courses.where(level: params[:level])
    end

    if params[:days]
      @courses = @courses.where(days: params[:days])
    end

    if params[:status]
      @courses = @courses.where(status: params[:status])
    end

    if params[:name]
      @courses = @courses.where(name: params[:name])
    end

    if params[:instructors]
      @courses = @courses.where(instructors: params[:instructors])
    end

    if params[:number]
      @courses = @courses.where(number: params[:number])
    end

    if params[:clbid]
      @courses = @courses.where(clbid: params[:clbid])
    end

    if params[:times]
      @courses = courses_including_values_at_key(@courses, :times, params[:times])
    end

    if params[:gereqs]
      @courses = courses_including_values_at_key(@courses, :gereqs, params[:gereqs])
    end

    if params[:num_of_ges]
      @courses = @courses.select { |course| course.num_of_ges == params[:num_of_ges].to_i }
    end

    render 'index.json.jb'
  end

  def show
    @course = Course.find_by_id(params[:id])

    render 'show.json.jb'
  end

  def create
    @course = Course.new(
      clbid: params[:clbid],
      credits: params[:credits],
      crsid: params[:crsid],
      department: params[:department],
      description: params[:description],
      enrolled: params[:enrolled],
      gereqs: params[:gereqs],
      instructors: params[:instructors],
      level: params[:level],
      max: params[:max],
      name: params[:name],
      notes: params[:notes],
      number: params[:number],
      offerings: params[:offerings],
      pn: params[:pn],
      prerequisites: params[:prerequisites],
      revisions: params[:revisions],
      section: params[:section],
      semester: params[:semester],
      status: params[:status],
      term: params[:term],
      course_type: params[:course_type],
      year: params[:year],
      days: params[:days],
      times: params[:times],
      location: params[:location],
      firstyear: params[:firstyear],
      sophmore: params[:sophmore],
      junior: params[:junior],
      senior: params[:senior]
    )
    if @course.save
      render 'show.json.jb'
    else
      render json: { errors: @course.errors.full_messages }
    end
  end

  def update
    @course = Course.find_by_id(params[:id])
    @course.update(
      clbid: params[:clbid] || @course.clbid,
      credits: params[:credits] || @course.credits,
      crsid: params[:crsid] || @course.crsid,
      department: params[:department] || @course.department,
      description: params[:description] || @course.description,
      enrolled: params[:enrolled] || @course.enrolled,
      gereqs: params[:gereqs] || @course.gereqs,
      instructors: params[:instructors] || @course.instructors,
      level: params[:level] || @course.level,
      max: params[:max] || @course.max,
      name: params[:name] || @course.name,
      notes: params[:notes] || @course.notes,
      number: params[:number] || @course.number,
      offerings: params[:offerings] || @course.offerings,
      pn: params[:pn] || @course.pn,
      prerequisites: params[:prerequisites] || @course.prerequisites,
      revisions: params[:revisions] || @course.revisions,
      section: params[:section] || @course.section,
      semester: params[:semester] || @course.semester,
      status: params[:status] || @course.status,
      term: params[:term] || @course.term,
      course_type: params[:course_type] || @course.course_type,
      year: params[:year] || @course.year,
      days: params[:days] || @course.days,
      times: params[:times] || @course.times,
      location: params[:location] || @course.location,
      firstyear: params[:firstyear] || @course.firstyear,
      sophmore: params[:sophmore] || @course.sophmore,
      junior: params[:junior] || @course.junior,
      senior: params[:senior] || @course.senior
    )
    render 'show.json.jb'
  end

  def destroy
    @course = Course.find_by_id(params[:id])
    @course.destroy
    render 'show.json.jb'
  end

  def labs
    course = Course.find_by_id(params[:id])
    @labs = course.labs
    render 'labs.json.jb'
  end
end
