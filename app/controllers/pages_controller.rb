class PagesController < ApplicationController
  def home
    @chefs = Chef.limit(24)
  end
end
