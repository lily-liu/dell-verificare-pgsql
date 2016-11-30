class Post < ApplicationRecord
  enum level: [:post, :comment]

  # has_many :comments, class_name: "Post", foreign_key: "parent_id"
  # belongs_to :post, class_name: "Post", foreign_key: "parent_id"
  belongs_to :user

  has_many :comments, :class_name => "Post", :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "Post", :foreign_key => "parent_id"
end
