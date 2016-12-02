require 'bcrypt'
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_user

  # GET /users/list
  def index
    @users = User.where("Level = ? OR Level = ? OR Level = ?", 2, 3, 4)
    if @users.present?
      render :index, status: :ok
    else
      @message = "no user found"
      render :error, status: :not_found
    end
  end

  # GET/NO /users/:id 
  def show
  end

  # POST /users/create
  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created#, location: @user
    else  
      @message = "Cannot insert data, user or email has exist"
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH /users/update/:id
  def update
    if @user.update(user_update_params)
      render :show, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/delete/:id
  def destroy
    if @user.destroy
      render :show, status: :ok
    else
      @message = @user.errors
      render :error, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.permit(:username, :password_digest, :level, :manager_id, :name, :email, :phone, :gender)
    user_data = {
      username: params.fetch(:username).to_s,
      password_digest: BCrypt::Password.create(params.fetch(:password_digest)),
      level: params.fetch(:level).to_i,
      manager_id: params.fetch(:manager_id).to_i,
      name: params.fetch(:name).to_s,
      email: params.fetch(:email).to_s,
      phone: params.fetch(:phone).to_s,
      gender: params.fetch(:gender).to_i
    }
  end

  def user_update_params
    params.permit(:password_digest, :level, :manager_id, :name, :email, :phone, :gender)
    user_data = {
      password_digest: BCrypt::Password.create(params.fetch(:password_digest)),
      level: params.fetch(:level).to_i,
      manager_id: params.fetch(:manager_id).to_i,
      name: params.fetch(:name).to_s,
      email: params.fetch(:email).to_s,
      phone: params.fetch(:phone).to_s,
      gender: params.fetch(:gender).to_i
    }
  end
end