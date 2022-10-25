# frozen_string_literal: true

require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @product = Product.create(name: "Coca Cola", price: 1500, category: "drink", size: 500)
  end

  def teardown
    Product.destroy_all
  end

  test 'should get new' do
    get products_new_url
    assert_response :success
  end

  test 'should get create' do
    post products_create_url, params: {name: "Coca Cola Light", price: 2000, category: "drink", size: 500}
    assert_response :redirect
  end

  test 'should get update' do
    put products_update_url(@product.id), params: {name: "Coca Cola", price: 1750, category: "drink", size: 500}
    assert_response :redirect
  end

  test 'should get edit' do
    get products_edit_url(@product.id)
    assert_response :success
  end

  test 'should get destroy' do
    delete products_destroy_url(@product.id)
    assert_response :redirect
  end

  test 'should get index' do
    get products_index_url
    assert_response :success
  end

end
