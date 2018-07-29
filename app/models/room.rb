class Room < ApplicationRecord
  belongs_to :user
  belongs_to :guest, class_name: 'User'
  has_many :comments
  has_many :comments_user, class_name: 'User', through: :comments, source: :user

  validates :user_id, presence: true
  validates :guest_id, presence: true
end
