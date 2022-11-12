# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def teardown
    Product.destroy_all
  end

  test 'Drink Product with valid params' do
    product = Product.new(name: 'Coca Cola', price: 1500, category: 'drink', size: 500)
    assert_equal(true, product.valid?)
  end

  test 'Food Product with valid params' do
    product = Product.new(name: 'SnackMix (de Todito>:c)', price: 1500, category: 'food', size: 500)
    assert_equal(true, product.valid?)
  end

  test 'Souvenir Product with valid params' do
    product = Product.new(name: 'Llavero', price: 1500, category: 'souvenir')
    assert_equal(true, product.valid?)
  end

  test 'Drink product without size' do
    product = Product.new(name: 'Coca Cola', price: 1500, category: 'drink')
    assert_equal(false, product.valid?)
  end

  test 'Drink product with invalid size' do
    product = Product.new(name: 'Coca Cola', price: 1500, category: 'drink', size: -500)
    assert_equal(false, product.valid?)
  end

  test 'Food product without size' do
    product = Product.new(name: 'Coca Cola', price: 1500, category: 'food')
    assert_equal(false, product.valid?)
  end

  test 'Food product with invalid size' do
    product = Product.new(name: 'Coca Cola', price: 1500, category: 'food', size: -500)
    assert_equal(false, product.valid?)
  end

  test 'Product without name' do
    product = Product.new(price: 1500, category: 'drink', size: 500)
    assert_equal(false, product.valid?)
  end

  test 'Product without price' do
    product = Product.new(name: 'Coca Cola', category: 'drink', size: 500)
    assert_equal(false, product.valid?)
  end

  test 'Product with invalid price' do
    product = Product.new(name: 'Coca Cola', price: -1500, category: 'drink', size: 500)
    assert_equal(false, product.valid?)
  end

  test 'Product without category' do
    product = Product.new(name: 'Coca Cola', price: 1500, size: 500)
    assert_equal(false, product.valid?)
  end

  test 'Product with invalid category' do
    assert_raise(ArgumentError) do
      Product.new(name: 'Coca Cola', price: 1500, category: 'hola', size: 500)
    end
  end

  test 'Food product size as string' do
    product = Product.new(name: 'Cabritas', price: 1000, category: 'food', size: 100)
    assert_equal('100.0 gr', product.size_string)
  end

  test 'Drink product size as string' do
    product = Product.new(name: 'Jugo', price: 1000, category: 'drink', size: 100)
    assert_equal('100.0 cc', product.size_string)
  end

  test 'Souvenir product size as string' do
    product = Product.new(name: '', price: 1000, category: 'souvenir')
    assert_equal('', product.size_string)
  end

  test 'Product price with 9 digits as string' do
    product = Product.new(name: 'Cabritas', price: 123_456_789, category: 'food', size: 100)
    assert_equal('$123.456.789', product.price_string)
  end

  test 'Product price with 3 digits' do
    product = Product.new(name: 'Jugo', price: 123, category: 'drink', size: 100)
    assert_equal('$123', product.price_string)
  end

  test 'product price with 4 digits as string' do
    product = Product.new(name: '', price: 1000, category: 'souvenir')
    assert_equal('$1.000', product.price_string)
  end
end
