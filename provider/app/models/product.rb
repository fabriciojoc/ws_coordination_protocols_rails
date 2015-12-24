class Product < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :name, :amount, :price
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than: 0 }
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "product.jpg"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

end
