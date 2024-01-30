class ChefsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chef, only: [:show, :edit, :update]

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    @chef.user = current_user
    if @chef.save
      redirect_to chef_path(@chef), notice: 'Your chef profile has been successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @chef.update(chef_params)
      redirect_to chef_path(@chef), notice: 'Your chef profile has been updated.'
    else
      render :edit
    end
  end

  private

  def set_chef
    @chef = Chef.find(params[:id])
  end

  def chef_params
    params.require(:chef).permit(:name, :specialty, :description)
  end
end