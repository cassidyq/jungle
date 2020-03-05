class Admin::SalesController < Admin::AdminMainController

  def index
    @sales = Sale.all
  end

  def new
  end

end
