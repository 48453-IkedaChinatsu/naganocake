class Public::ItemsController < ApplicationController
 
 
 
 def index
    @item = Item.new
    @items= Item.all
    @search = Item.ransack(params[:q])
    @items = @search.result.page(params[:page]).per(8)
 end
 
 def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
 end
 
end