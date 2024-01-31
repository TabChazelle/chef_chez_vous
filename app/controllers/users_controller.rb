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

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  # def my_profile
  #   @user = current_user
  #   render :show
  # end

  def toggle_chef
    @user = current_user
    if @user
      @user.update(chef: !@user.chef) # Toggle the chef status
      redirect_to @user, notice: "Chef status updated successfully."
    else
      redirect_to root_path, alert: "You must be logged in to perform this action."
    end
  end

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
