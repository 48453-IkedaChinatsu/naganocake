class Admin::ItemsController < ApplicationController
    
    def new
     @item = Item.new
    end
    
    def index
     @item = Item.new
     @items = Item.all
    end
    
    def show
    @item = Item.find(params[:id])
    end
    
    def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path(@item)
    else
      flash[:genre_created_error] = "ジャンル名を入力してください"
    redirect_to new_admin_items_path
    end
    end
    
    private
     # ストロングパラメータ
  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :image, :is_active)
  end
    
end
