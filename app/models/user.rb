class User < ActiveRecord::Base
  has_many :groups 
  has_many :groups_jioned, through: :user_group, source: :group
  has_many :user_groups, dependent: :destroy
  has_secure_password

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, presence: true, :uniqueness => { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :first_name, :last_name, :password, presence: true
end
