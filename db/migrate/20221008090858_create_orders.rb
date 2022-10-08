class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.datetime :date
      t.references :customer
      t.decimal :amount, precision: 10, scale: 2
      t.decimal :discount, precision: 10, scale: 2
      t.decimal :net_amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
