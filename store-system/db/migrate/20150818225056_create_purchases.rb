class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :product_name
      t.decimal :price
      t.string :card_number
      t.integer :provider_id
      t.integer :user_id
      t.integer :bank_id
      t.string :status

      t.timestamps null: false
    end
  end
end
