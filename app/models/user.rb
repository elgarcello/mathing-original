class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationship, source: :user
  
  has_one :profile
  
  has_many :rooms
  has_many :guests, through: :rooms, source: :guest
  has_many :reverse_of_rooms, class_name: 'Room', foreign_key: 'guest_id'
  has_many :hosts, through: :reverse_of_rooms, source: :user
  
  has_many :comments
  has_many :comments_room, class_name: 'Room', through: :comments, source: :room
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def matches
    followings & followers
  end
  
  def open_room(guest)
    unless self == guest
      self.rooms.create(guest_id: guest.id)
    end
  end
  
  def send_comment(room, content)
    self.comments.create(room_id: room.id, content: content)
  end
end
