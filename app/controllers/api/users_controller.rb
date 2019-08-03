class Api::UsersController < ApplicationController

  def index
    @users = User.all
    render 'index.json.jb'
  end

  def show
    @user = User.find_by_id(params[:id])
    render 'show.json.jb'
  end

  def create
    user = User.new(
      name: params[:name],
      username: params[:username],
      email: params[:email],
      enrollment_year: params[:enrollment_year],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )

    if user.save
      enrollment_year = params[:enrollment_year].to_i
      4.times do |year|
        year = enrollment_year + year
        3.times do |semester|
          semester += 1
          term = "#{year}#{semester}"
          2.times do |order|
            order += 1
            Term.create(
              year: year,
              semester: semester,
              term: term,
              order: order,
              user_id: user.id
            )
          end
        end
      end
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    @user = User.find_by_id(params[:id])
    @user.update(
      name: params[:name] || @user.name,
      username: params[:username] || @user.username,
      email: params[:email] || @user.email,
      enrollment_year: params[:enrollment_year] || @user.enrollment_year
    )
    render 'show.json.jb'
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    render 'show.json.jb'
  end
end
