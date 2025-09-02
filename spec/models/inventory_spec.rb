require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      inventory = build(:inventory)
      expect(inventory).to be_valid
    end

    it 'is invalid without available_quantity' do
      inventory = build(:inventory, available_quantity: nil)
      expect(inventory).not_to be_valid
      expect(inventory.errors[:available_quantity]).to include("can't be blank")
    end

    it 'is invalid with negative available_quantity' do
      inventory = build(:inventory, available_quantity: -1)
      expect(inventory).not_to be_valid
      expect(inventory.errors[:available_quantity]).to include('must be greater than or equal to 0')
    end

    it 'is valid with zero available_quantity' do
      inventory = build(:inventory, available_quantity: 0)
      expect(inventory).to be_valid
    end

    it 'is invalid with duplicate product-store combination' do
      product = create(:product)
      store = create(:store)
      create(:inventory, product: product, store: store)
      inventory = build(:inventory, product: product, store: store)
      expect(inventory).not_to be_valid
      expect(inventory.errors[:product_id]).to include('and store combination must be unique')
    end
  end

  describe 'associations' do
    it 'belongs to product' do
      association = described_class.reflect_on_association(:product)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to store' do
      association = described_class.reflect_on_association(:store)
      expect(association.macro).to eq :belongs_to
    end
  end
end
