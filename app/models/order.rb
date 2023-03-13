class Order < ApplicationRecord
    enum payment_method: { credit_card: 0, transfer: 1 }
    belongs_to :customer
    has_many :order_details
    
     def address_display
       '〒' + post_code + ' ' + address + ' ' + delivery_target_name
     end
end
