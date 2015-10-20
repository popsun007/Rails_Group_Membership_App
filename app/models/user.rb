class User < ActiveRecord::Base
  has_many :groups 
  has_many :groups_jioned, through: :user_group, source: :group
  has_many :user_groups, dependent: :destroy
  has_secure_password

  validates :first_name, :last_name, :password, presence: true
end
