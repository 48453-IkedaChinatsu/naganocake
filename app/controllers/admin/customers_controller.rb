class Admin::CustomersController < ApplicationController
    
  def index
     @customer = Customer.new
     @customers = Customer.page(params[:page]).per(10)
  end
  
  def
     @customer = Customer.find(params[:id])
  end
end
