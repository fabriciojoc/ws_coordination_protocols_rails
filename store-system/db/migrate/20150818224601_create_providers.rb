class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :description
      t.string :wsdl_location
      t.decimal :percentage

      t.timestamps null: false
    end
  end
end
