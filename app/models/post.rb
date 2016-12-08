class Post < ApplicationRecord
  enum level: [:post, :comment]

  belongs_to :user
  belongs_to :parent, :class_name => "Post", :foreign_key => "parent_id"
  has_many :comments, :class_name => "Post", :foreign_key => "parent_id"

  validates :title, :content, :user, :level, presence: true
end
