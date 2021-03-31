class Admin::DashboardController < ApplicationController
  # http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD'] 
  http_basic_authenticate_with(
      name: ENV['ADMIN_USERNAME'],
      password: ENV['ADMIN_PASSWORD']
    )
  def show
    # Display a count of how many products are in the database
    @products = Product.all
    @products_count= @products.count

    # Display a count of how many categories are in the database
    @category = Category.all
    @category_count= @category.count
  end
end
