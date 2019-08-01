class Api::TermsController < ApplicationController
  def index
    if !current_user
      render json: { message: 'login in' }
      return
    end

    @terms = Term.all
    render 'index.json.jb'
  end

  def show
    if !current_user
      render json: { message: 'login in' }
      return
    end

    @term = Term.find_by_id(params[:id])
    render 'show.json.jb'
  end

  def update
    if !current_user
      render json: { message: 'login in' }
      return
    end

    @term = Term.find_by_id(params[:id])
    @term.update(
      year: params[:year] || @term.year,
      semester: params[:semester] || @term.semester
    )
    render 'show.json.jb'
  end

  def create
    if !current_user
      render json: { message: 'login in' }
      return
    end

    @term = Term.new(
      year: params[:year],
      semester: params[:semester],
      planner_id: params[:planner_id]
    )
    @term.save
    render 'show.json.jb'
  end

  def destroy
    if !current_user
      render json: { message: 'login in' }
      return
    end

    @term = Term.find_by_id(params[:id])
    @term.destroy
    render 'show.json.jb'
  end
end
