class Bank < ActiveRecord::Base
  has_many :purchases
end
