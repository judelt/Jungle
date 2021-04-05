require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "should save a product with all four fields successfully" do
      @category = Category.create(name:"Clothes")
      @product = Product.new(
        name: "Shirt",
        price_cents: 3000,
        quantity: 1,
        category_id: @category.id
      )
      expect(@product).to be_valid
    end

    it 'should validate if name is present before saving' do
      @category = Category.new(name: "Clothes")
      @product = Product.new(
        name: nil, 
        price_cents: 2000, 
        quantity: 1, 
        category_id: @category.id)
        expect(@product).to_not be_valid
        expect(@product.errors[:name]).to include("can't be blank")
    end

    it 'should validate if price is present before saving' do
      @category = Category.create(name: "Clothes")
      @product = Product.new(
        name: "T-Shirt",
        price: nil,
        quantity: 1,
        category_id: @category.id
      )
      expect(@product).to_not be_valid
      expect(@product.errors[:price]).to include("is not a number")
    end

    it 'should validate if quantity is present before saving' do
      @category = Category.create(name: "Clothes")
      @product = Product.new(
        name: "Hoodie",
        price: 4000,
        quantity: nil,
        category_id: @category.id
      )
      expect(@product).to_not be_valid
      expect(@product.errors[:quantity]).to include("can't be blank")
    end

    it 'should validate if category is present before saving' do
      @category = Category.create(name: "Clothes")
      @product = Product.new(
        name: "Gloves",
        price: 3000,
        quantity: 1,
        category_id: nil
      )
      expect(@product).to_not be_valid
      expect(@product.errors[:category]).to include("can't be blank")
    end

  end
end