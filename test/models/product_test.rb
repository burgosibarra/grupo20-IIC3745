# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def teardown
    Product.destroy_all
  end

  test 'Product with valid params' do
    product = Product.create(name: 'Coca Cola', price: 1500, category: 'drink', size: 500)
    assert_equal(true, product.valid?)
  end

  test 'Product with invalid params' do
    product = Product.create(name: 'Coca Cola', price: -1500, category: 'drink', size: -500)
    assert_equal(false, product.valid?)
  end

  test 'Drink product without size' do
    product = Product.create(name: 'Coca Cola', price: -1500, category: 'drink')
    assert_equal(false, product.valid?)
  end

  test 'Food product without size' do
    product = Product.create(name: 'Coca Cola', price: -1500, category: 'food')
    assert_equal(false, product.valid?)
  end
end
