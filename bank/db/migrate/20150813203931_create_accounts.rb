class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :agency
      t.string :account
      t.string :password
      t.decimal :balance
      t.decimal :transaction_balance
      t.integer :holder_id

      t.timestamps null: false
    end
  end
end
