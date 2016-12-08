class Posm < ApplicationRecord
  enum category: [:brosur, :x_banner, :flyer, :katalog, :wobler, :topper, :poster, :sheiftalker, :brosur_holder, :notebook_tray, :sticker, :tent_card, :mini_banner]
  has_many :posm_store_inventories, dependent: :nullify
  has_many :stores, through: :posm_store_inventories, dependent: :nullify

  validates :name, :quantity, presence: true
  validates :quantity, numericality: {only_integer: true}
end
