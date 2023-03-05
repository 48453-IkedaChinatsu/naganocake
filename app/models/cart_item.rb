class CartItem < ApplicationRecord
    
    belongs_to :order
    belongs_to :item   
    
    def sum_price # 実際に作成したサイトは税金も算出していたのでメソッドを記載
        item.taxin_price*quantity
    end
end
