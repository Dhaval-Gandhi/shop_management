class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order
      t.references :item
      t.decimal :qty, precision: 10, scale: 3
      t.decimal :rate, precision: 10, scale: 2
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
