class Post < ApplicationRecord
  validates :title, presence: true
  validates :subs, presence: { message: "Must have at least one sub"}

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs
  has_many :comments

  def comments_by_parent_id
    comments_by_parent = Hash.new { |hash, key| hash[key] = [] }

    self.comments.includes(:author).each do |comment|
      comments_by_parent[comment.parent_comment_id] << comment
    end

    comments_by_parent
  end
end
