class Sub < ApplicationRecord
  validates :title, :description, presence: true

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

  has_many :posts
end
