class Store < ApplicationRecord
  validates :name, presence: true

  has_many :inventories, dependent: :destroy
  has_many :products, through: :inventories
end
