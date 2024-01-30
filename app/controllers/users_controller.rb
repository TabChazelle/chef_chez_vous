class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy profile]

  def index
    @users = User.all
  end

  def show
  end

  def profile
    @user = User.find(params[:id])
    render :profile
  end
  
  # def my_profile
  #   @user = current_user
  #   render :show
  # end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to my_profile_path, notice: 'Your profile has been updated.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
