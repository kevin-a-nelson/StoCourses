class Api::PlannersController < ApplicationController
  def show
    @planner = Planner.find_by_id(params[:id])
    render 'show.json.jb'
  end

  def create
    @planner = Planner.new(
      name: params[:name],
      year: params[:year],
      semester: params[:semester],
      user_id: current_user.id
    )
    if @planner.save
      render 'show.json.jb'
    else
      render json: { errors: @planner.errors.full_messages }
    end
  end

  def index
    if current_user
      @planners = current_user.planners
      render 'index.json.jb'
    else
      render json: { message: 'log in' }
    end
  end
end
