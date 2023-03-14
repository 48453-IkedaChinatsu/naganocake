class Public::OrdersController < ApplicationController
    
  def new
      @order = Order.new
      @addresses = current_customer.addresses
      # binding.pry
  end
  
  
  
  def create
      @cart_items = current_customer.cart_items.all
      @order = current_customer.orders.new(order_params)
      @order.save!
      @cart_items.each do|cart_item|
      order_detail = OrderDetail.new(order_id: @order.id)
      order_detail.item_id = cart_item.item.id
      order_detail.quantity = cart_item.quantity
      order_detail.price = (cart_item.item.price * 1.1).floor
      order_detail.save!
  end
      @cart_items.destroy_all
      redirect_to orders_thanks_path
  end   
      
 
  def index
      @orders = current_customer.orders
  end


  def confirm
       @order = Order.new(order_params)
       @order.shipping_cost = 800
       @sum = 0
       @cart_items = current_customer.cart_items.all 
       @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
       
    if params[:order][:address_number] == "1"
       @order.delivery_target_name = current_customer.last_name + current_customer.first_name
       @order.address = current_customer.address
       @order.post_code = current_customer.postal_code
       
    elsif params[:order][:address_number] == "2"
       @address = Address.find(params[:order][:address_for_order])
       @order.delivery_target_name = @address.name
       @order.address =  @address.address
       @order.post_code =  @address.postal_code
   
    elsif params[:order][:address_number] == "3"
      
    end
  end


  def complete
		order = Order.new(session[:order])
		order.save

		if session[:new_address]
			address = current_customer.addresses.new
			address.postal_code = order.post_code
			address.address = order.address
			address.name = order.name
			address.save
			session[:new_address] = nil
		end

		# 以下、order_detail作成
		  cart_items = current_customer.cart_items
		  cart_items.each do |cart_item|
			order_detail = OrderDetail.new
			order_detail.order_id = order.id
			order_detail.item_id = cart_item.item.id
			order_detail.quantity = cart_item.quantity
			order_detail.making_status = 0
			order_detail.price = (cart_item.item.price * 1.1).floor
			order_detail.save
		end

		# 購入後はカート内商品削除
		cart_items.destroy_all
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
       @cart_items = current_customer.cart_items.all 
       @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
       
    if params[:order][:address_number] == "1"
       @order.delivery_target_name = current_customer.last_name + current_customer.first_name
       @order.address = current_customer.customer_address
       @order.post_code = current_customer.postal_code
       
    elsif params[:order][:address_number] == "2"
       @address = Address.find(params[:order][:address_for_order])
       @order.delivery_target_name = @address.name
       @order.address =  @address.address
       @order.post_code =  @address.postal_code
   
    elsif params[:order][:address_number] == "3"
      
    end
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
      params.require(:order).permit(:delivery_target_name, :address, :total_price, :post_code, :payment_method, :shipping_cost, :request_amount)
  end

# def address_params
#       params.require(:order).permit(:delivery_target_name, :address, :postal_code)
# end
  
end