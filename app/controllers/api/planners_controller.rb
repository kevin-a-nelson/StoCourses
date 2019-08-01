class Api::PlannersController < ApplicationController
  def index
    if current_user
      @planners = current_user.planners
      render 'index.json.jb'
    else
      render json: { message: 'log in' }
    end
  end

  def show
    @planner = Planner.find_by_id(params[:id])
  end

  def update
    if current_user
      @planner = Planner.find_by_id(params[:id])
      @planner.update(
        name: params[:name] || @planner.name,
        user_id: current_user.id || @planner.user_id
      )
    else
      render json: { message: 'log in' }
    end
  end

  def create
    @planner = Planner.new(
      name: params[:name],
      user_id: current_user.id
    )
    if @planner.save
      render 'show.json.jb'
    else
      render json: { errors: @planner.errors.full_messages }
    end
  end

end
