class Api::TermsController < ApplicationController
  def index
    @terms = Term.all
    render 'index.json.jb'
  end

  def show
    @term = Term.find_by_id(params[:id])
    render 'show.json.jb'
  end

  def update
    @term = Term.find_by_id(params[:id])
    @term.update(
      year: params[:year] || @term.year,
      semester: params[:semester] || @term.semester
    )
    render 'show.json.jb'
  end

  def create
    @term = Term.new(
      year: params[:year],
      semester: params[:semester],
      planner_id: 1
    )
    @term.save
    render 'show.json.jb'
  end

  def destroy
    @term = Term.find_by_id(params[:id])
    @term.destroy
    render 'show.json.jb'
  end 
end
