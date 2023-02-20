class Admin::GenresController < ApplicationController
    
  def index
    @genre = Genre.new
    @genres = Genre.all
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end
  
   def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      flash[:genre_created_error] = "ジャンル名を入力してください"
    redirect_to
    end
   end

   private
    # ストロングパラメータ
    def genre_params
    params.require(:genre).permit(:name, :is_genres_status)
    end
  
end
