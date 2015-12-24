class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :purchases

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :default_create_values, :on => :create

  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email

  protected
    def default_create_values
      self.role = "user"
    end
end
