class Public::AddressesController < ApplicationController
    
     # 配送先一覧/配送先登録画面
    def index
     @address = Address.new
     @addresses = current_customer.addresses
     #@addresses = current_addresses
    end
    
     # 配送先登録ボタン
    def create
        @address = Address.new(address_params)
        @addresses = Address.all
        @address.customer_id = current_customer.id
        # binding.pry
        if @address.save!
            redirect_to addresses_path(@addresses),notice:'Address is create'
        else
            flash[:success] = "登録しました。"
            redirect_to root_path
        end
    end
    
   
     # 配送先を削除する
    def destroy
        address = Address.find(params[:id])
        address.destroy
        redirect_to addresses_path
    end 

     # 配送先編集ボタン
    def edit
        @address = Address.find(params[:id])
    end

     # 配送先編集保存ボタン
    def update
        @address = Address.find(params[:id])
       if @address.update(address_params)
        redirect_to addresses_path
       else
        render :edit
       end
    end

    private
    def address_params
        params.require(:address).permit(:customer_id, :name, :postal_code, :address)
    end 
   
end
