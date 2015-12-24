class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :name
      t.string :wsdl_location

      t.timestamps null: false
    end
  end
end
