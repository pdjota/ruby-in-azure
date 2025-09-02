class Inventory < ApplicationRecord
  belongs_to :product
  belongs_to :store

  validates :available_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :product_id, uniqueness: { scope: :store_id, message: "and store combination must be unique" }
end
