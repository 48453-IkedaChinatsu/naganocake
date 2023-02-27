class Admin::HomesController < ApplicationController
  
  def top
    @order = Order.new
    @orders = Order.page(params[:page]).per(10)
  end
  
  def about
    
  end
    
end
