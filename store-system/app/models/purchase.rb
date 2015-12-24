class Purchase < ActiveRecord::Base
  belongs_to :provider
  belongs_to :user
  belongs_to :bank

  validates_presence_of :bank_id, :card_number, :price, :provider_id, :product_name, :user_id, :status
end
