class PagesController < ApplicationController
  def home
    @chefs = Chef.page(params[:page]).per(24)
    respond_to do |format|
      format.html
      format.json { render json: @chefs }
    end
  end

  def infinite_scroll
    @chefs = Chef.page(params[:page]).per(3) # Assuming you're showing 3 chefs per row
    render json: @chefs.map { |chef|
      {
        id: chef.id,
        name: chef.name,
        specialty: chef.specialty,
        price_per_day: chef.price_per_day,
        image_url: cl_image_path(chef.photo, height: 300, width: 400, crop: :fill),
        profile_path: chef_path(chef),
        rating: chef.rating, # Replace with actual rating logic
        review_count: chef.reviews.count # Replace with actual review count logic
      }
    }
  end
end
