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
    @course_term = CourseTerm.find_by_id(params[:id])
    @course_term.destroy
    render 'show.json.jb'
  end
end
