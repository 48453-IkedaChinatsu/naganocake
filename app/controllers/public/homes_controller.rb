class Public::HomesController < ApplicationController
  
  def top
    @item = Item.new
    @item = Item.all
    @genres = Genre.all
  end
  
  def image
    @image = Post.where(image_id: current_image.id).where.not(image: nil)
  end
  
  def about
  
  end
  
  def unsubscribe
    
  end
end
 