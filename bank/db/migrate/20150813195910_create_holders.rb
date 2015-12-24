class CreateHolders < ActiveRecord::Migration
  def change
    create_table :holders do |t|
      t.string :name
      t.string :cpf
      t.integer :account_id

      t.timestamps null: false
    end
  end
end
