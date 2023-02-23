class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.integer :customer_id
      t.integer :request_amount
      t.integer :shipping_cost
      t.integer :payment_method,default: 0,null: false
      t.integer :order_status,default: 0,null: false
      t.string  :post_code
      t.string  :address
      t.string  :delivery_target_name
      t.timestamps
    end
  end
end
