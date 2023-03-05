class Public::OrdersController < ApplicationController
  def new
      @order = Order.new
  end
  
  def create
      @cart_items = current_customer.cart_items.all
      @order = current_customer.orders.new(order_params)
  def index
  end

  def show
      @order = Order.find(params[:id])
		  @order_details = @order.order_details
	 if @order.save
	    cart_items.each do |cart|
	    order_item = OrderItem.new
	    order_item.item_id = cart.item_id
      order_item.order_id = @order.id
      order_item.order_quantity = cart.quantity
      order_item.save
   end
      redirect_to 遷移したいページのパス
      cart_items.destroy_all
   else
      @order = Order.new(order_params)
      render :new
   end
  end
  end
  
  
  
end
