class Api::TermsController < ApplicationController
  def index
    if !current_user
      render json: { message: 'login in' }
      return
    end

    @terms = current_user.terms
    render 'index.json.jb'
  end

  def show
    if !current_user
      render json: { message: 'login in' }
      return
    end

    @term = current_user.terms.find_by_id(params[:id])
    render 'show.json.jb'
  end

  def update
    if !current_user
      render json: { message: 'login in' }
      return
    end

    @term = current_user.terms.find_by_id(params[:id])

    if @term.update(
      order: params[:order] || @term.order,
      year: params[:year] || @term.year,
      semester: params[:semester] || @term.year,
      term: params[:term] || @term.term
    )
      render 'show.json.jb'
    else
      render json: { message: @term.errors.full_messages }
    end
  end

  def create
    if !current_user
      render json: { message: 'login in' }
      return
    end

    terms = current_user.terms.where(term: params[:term])
    term_order = terms.count + 1

    @term = Term.new(
      term: params[:term],
      year: params[:year],
      semester: params[:semester],
      user_id: current_user.id,
      order: term_order
    )

    if @term.save
      render 'show.json.jb'
    else
      render json: { errors: @term.errors.full_messages }
    end
  end

  def destroy
    if !current_user
      render json: { message: 'login in' }
      return
    end

    @term = current_user.terms.find_by_id(params[:id])
    @term.destroy

    render 'show.json.jb'
  end
end
