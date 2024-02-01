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
      redirect_to profile_user_path(@user)
    else
      redirect_to root_path, alert: "You must be logged in to perform this action."
    end
  end

  def edit
    @user = current_user
  end


def update
  @user = current_user
  respond_to do |format|
    if @user.update(user_params)
      format.json { render json: { message: 'Your profile has been updated.' }, status: :ok }
    else
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end


  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :biography, :specialty)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
