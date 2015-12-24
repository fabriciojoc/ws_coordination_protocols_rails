class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.integer :amount
      t.integer :transaction_amount
      t.string :video
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
