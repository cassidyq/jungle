class Admin::DashboardController < Admin::AdminMainController
  
  def show
    @products_count = Product.all().count(:name)
    @categories_count = Category.all().count(:name)
  end
end
