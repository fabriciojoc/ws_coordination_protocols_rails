class Card < ActiveRecord::Base
  belongs_to :account
  validates_presence_of :number, :expiration_date, :security_code, :password, :account_id
  validates_length_of :number, :is => 16
  validates_length_of :security_code, :is => 3
  validates_length_of :password, :within => 6..128
  validates_uniqueness_of :number

end
