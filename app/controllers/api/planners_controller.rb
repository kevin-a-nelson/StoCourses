class Api::PlannersController < ApplicationController

  def index
    if !current_user
      render json: { message: 'please log in' }
      return
    end

    @planners = current_user.planners
    render 'index.json.jb'
  end

  def show
    if !current_user
      render json: { message: 'please log in' }
      return
    end

    @planners = current_user.planners
    @planner = @planners.find_by_id(params[:id])
    render 'show.json.jb'
  end

  def update
    if !current_user
      render json: { message: 'please log in' }
      return
    end

    @planners = current_user.planners
    @planner = @planners.find_by_id(params[:id])
    @planner.update(
      name: params[:name] || @planner.name,
      user_id: current_user.id || @planner.user_id
    )
    render 'show.json.jb'
  end

  def create
    if !current_user
      render json: { message: 'please log in' }
      return
    end

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

  def destroy
    if !current_user
      render json: { message: 'please log in' }
      return
    end

    planners = current_user.planners
    @planner = planners.find_by_id(params[:id])
    @planner.destroy

    render 'show.json.jb'
  end

  def terms
    if !current_user
      render json: { message: 'please log in' }
      return
    end

    planners = current_user.planners
    planner = planners.find_by_id(params[:id])
    @terms = planner.terms

    render 'terms.json.jb'
  end
end
