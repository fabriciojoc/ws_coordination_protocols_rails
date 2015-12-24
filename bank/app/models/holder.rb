class Holder < ActiveRecord::Base
  has_one :account
  validates_presence_of :name, :cpf
end
