require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      product = build(:product)
      expect(product).to be_valid
    end

    it 'is invalid without a name' do
      product = build(:product, name: nil)
      expect(product).not_to be_valid
      expect(product.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a barcode' do
      product = build(:product, barcode: nil)
      expect(product).not_to be_valid
      expect(product.errors[:barcode]).to include("can't be blank")
    end

    it 'is invalid with duplicate barcode' do
      create(:product, barcode: '123456789')
      product = build(:product, barcode: '123456789')
      expect(product).not_to be_valid
      expect(product.errors[:barcode]).to include('has already been taken')
    end
  end

  describe 'associations' do
    it 'has many inventories' do
      association = described_class.reflect_on_association(:inventories)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many stores through inventories' do
      association = described_class.reflect_on_association(:stores)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :inventories
    end
  end
end
