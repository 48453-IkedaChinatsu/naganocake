class Public::ItemsController < ApplicationController
 
 
 
 def index
    @item = Item.new
    if params[:genre_id].present?
       @items = Item.where(genre_id:params[:genre_id])
   else
       @items = Item.all
   end
    #@search = Item.ransack(params[:q])
    #@items = @search.result.page(params[:page]).per(8)
 end

 def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
 end
 
end