class AddPhotoToProducts < ActiveRecord::Migration
  def up
    add_attachment :products, :photo
  end

  def down
    remove_attachment :products, :photo
  end
end
