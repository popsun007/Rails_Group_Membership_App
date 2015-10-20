class Group < ActiveRecord::Base
  belongs_to :user
  has_many :users_jioned, through: :user_group, source: :user
  has_many :user_groups, dependent: :destroy

  validates :name, presence: true, length: {minimum: 5}
  validates :description, presence: true, length: {minimum: 10}
end
