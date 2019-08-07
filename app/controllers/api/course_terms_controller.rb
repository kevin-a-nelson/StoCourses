class Api::CourseTermsController < ApplicationController
  def index
    @course_terms = CourseTerm.all
    render 'index.json.jb'
  end

  def show
    @course_term = CourseTerm.find_by_id(params[:id])
    render 'show.json.jb'
  end

  def create
    @course_term = CourseTerm.new(
      course_id: params[:course_id],
      term_id: params[:term_id]
    )

    if @course_term.save
      render 'show.json.jb'
    else
      render json: { message: @course_term.errors.full_messages }
    end
  end

  def update
    @course_term = CourseTerm.find_by_id(params[:id])
    @course_term.update(
      course_id: params[:course_id] || @course_term.course_id,
      term_id: params[:term_id] || @course_term.term_id
    )

    render 'show.json.jb'
  end

  def destroy
    if params[:id]
      @course_term = CourseTerm.find_by_id(params[:id])
    elsif params[:course_id] && params[:term_id]
      @course_term = CourseTerm.where(term_id: params[:term_id]).where(course_id: params[:course_id]).limit(1)
    end

    @course_term = @course_term[0]

    if @course_term
      @course_term.destroy
      render 'show.json.jb'
    else
      render json: { errors: 'some error occured' }
    end
  end
end
