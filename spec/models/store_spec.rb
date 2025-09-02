require 'rails_helper'

RSpec.describe Store, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      store = build(:store)
      expect(store).to be_valid
    end

    it 'is invalid without a name' do
      store = build(:store, name: nil)
      expect(store).not_to be_valid
      expect(store.errors[:name]).to include("can't be blank")
    end

    it 'is valid without address' do
      store = build(:store, address: nil)
      expect(store).to be_valid
    end

    it 'is valid without contact_info' do
      store = build(:store, contact_info: nil)
      expect(store).to be_valid
    end
  end

  describe 'associations' do
    it 'has many inventories' do
      association = described_class.reflect_on_association(:inventories)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many products through inventories' do
      association = described_class.reflect_on_association(:products)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :inventories
    end
  end
end
