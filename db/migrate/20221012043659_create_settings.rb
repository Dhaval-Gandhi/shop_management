class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.string :cmp_name
      t.text :cmp_address
      t.string :cmp_gst
      t.string :totp_key

      t.timestamps
    end
  end
end
