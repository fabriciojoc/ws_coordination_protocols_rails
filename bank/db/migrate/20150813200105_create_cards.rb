class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :number
      t.datetime :expiration_date
      t.string :security_code
      t.string :password
      t.integer :account_id

      t.timestamps null: false
    end
  end
end
