require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:all) do 
      @category = Category.create({name: 'test'})
    end

    context 'all' do 
      it 'saves successfully when all fields are present' do 
        @product = Product.create({
          name: 'Example product',
          price: '100',
          quantity: 10,
          category: @category
        })

        expect(@product.errors).to be_empty
      end
    end

    context 'name' do
      it 'returns an error when the name is missing' do 
        @product = Product.create({
          price: '100',
          quantity: 10,
          category: @category
        })

        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end

    context 'quantity' do
      it 'returns an error when the quantity is missing' do 
        @product = Product.create({
          price: '100',
          name: 'Bob',
          category: @category
        })

        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    context 'price' do
      it 'returns an error when the price is missing' do 
        @product = Product.create({
          name: 'Bob',
          quantity: 10,
          category: @category
        })

        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
    end

    context 'category' do
      it 'returns an error when the category is missing' do 
        @product = Product.create({
          price: '100',
          quantity: 10,
          name: 'Bob'
        })

        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end
  end
end
