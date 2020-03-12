class Admin::DashboardController < Admin::AdminMainController
  
  def show
    @products_count = Product.count(:name)
    @categories_count = Category.count(:name)
    @sales_count = Sale.count(:name)
  end
end
