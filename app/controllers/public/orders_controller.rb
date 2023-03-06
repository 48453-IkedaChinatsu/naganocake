class Public::OrdersController < ApplicationController
    
  def new
      @order = Order.new
      @addresses = current_customer.addresses
  end
  
  
  
  def create
      @cart_items = current_customer.cart_items.all
      @order = current_customer.orders.new(order_params)
  end   
      
      
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

  
  
  
  def check
       @order = Order.new(order_params)
    if params[:order][:address_number] == "1"
       @order.name = current_customer.name 
       @order.address = current_customer.customer_address
    elsif 
       params[:order][:address_number] == "2"
    if Address.exists?(name: params[:order][:registered])
       @order.name = Address.find(params[:order][:registered]).name
       @order.address = Address.find(params[:order][:registered]).address
    else
       render :new
    end
    elsif 
       params[:order][:address_number] == "3"
       address_new = current_customer.addresses.new(address_params)
    if address_new.save 
    else
       render :new
    end
    else
       redirect_to 遷移したいページ 
    end
       @cart_items = current_customer.cart_items.all 
       @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
  end
  
  
  def thanks
		order = Order.new(session[:order])
		order.save

		if session[:address]
			address = current_customer.shipping_addresses.new
			address.postal_code = order.post_code
			address.address = order.address
			address.name = order.name
			address.save
			session[:address] = nil
		end
  end


private

  def order_params
      params.require(:order).permit(:name, :address, :total_price)
  end

  def address_params
      params.require(:order).permit(:name, :address)
  end
  
end