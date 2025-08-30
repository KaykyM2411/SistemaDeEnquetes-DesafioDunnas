class User < ApplicationRecord
  has_secure_password

  enum :user_type, { user: 0, admin: 1 }

  validates :email, presence: true, uniqueness: true
  validates :user_type, presence: true

  has_many :polls
  has_many :votes, dependent: :destroy
  has_many :voted_polls, through: :votes, source: :poll
end
