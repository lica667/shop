class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :email

  attr_accessor :temp_password
  before_update :update_user

  def update_user
    self.password = self.temp_password unless self.temp_password.blank?
  end
end
