class Account < ActiveRecord::Base
  belongs_to :holder
  has_many :cards
  validates_presence_of :agency, :account, :password, :balance, :holder_id
  validates_length_of :password, :within => 6..128
  validates_uniqueness_of :agency, :scope => :account
end
