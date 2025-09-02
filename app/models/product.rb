class Product < ApplicationRecord
  validates :name, presence: true
  validates :barcode, presence: true, uniqueness: true

  has_many :inventories, dependent: :destroy
  has_many :stores, through: :inventories
end
