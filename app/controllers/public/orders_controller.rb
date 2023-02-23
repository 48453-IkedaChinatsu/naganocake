class Public::OrdersController < ApplicationController
  def new
  end

  def index
  end

  def show
    @order = Order.find(params[:id])
		@order_details = @order.order_details
  end
end
