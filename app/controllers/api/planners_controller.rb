class Api::PlannersController < ApplicationController
  def show
    @planner = Planner.find_by_id(params[:id])
    render 'show.json.jb'
  end

  def create
    
  end
end
