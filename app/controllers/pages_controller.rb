class PagesController < ApplicationController
  def home
    @chefs = Chef.all
  end
end
