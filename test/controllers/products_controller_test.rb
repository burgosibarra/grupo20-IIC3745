# frozen_string_literal: true

require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  class ProductsControllerWithoutAProductTest < ActionDispatch::IntegrationTest
    def setup; end

    def teardown
      Product.destroy_all
    end

    test 'should get new' do
      get products_new_url
      assert_response :success
    end

    test 'should redirect when post create with valid params' do
      post products_create_url,
           params: { name: 'Coca Cola Light', price: 2000, category: 'drink', size: 500 }
      assert_response :redirect
    end

    test 'should create a new Product when valid params are given' do
      assert_difference 'Product.count', 1 do
        post products_create_url,
             params: { name: 'Coca Cola Light', price: 2000, category: 'drink', size: 500 }
      end
    end

    test 'should redirect when post create with invalid params' do
      post products_create_url,
           params: { name: 'Coca Cola Light', price: 2000, category: 'drink', size: -500 }
      assert_response :redirect
    end

    test 'should not create a new Product when invalid params are given' do
      assert_difference 'Product.count', 0 do
        post products_create_url,
             params: { name: 'Coca Cola Light', price: 2000, category: 'drink', size: -500 }
      end
    end
  end

  class ProductsControllerWithAProductTest < ActionDispatch::IntegrationTest
    def setup
      @product = Product.create(name: 'Coca Cola', price: 1500, category: 'drink', size: 500)
    end

    def teardown
      Product.destroy_all
    end

    test 'should redirect when put valid product with valid params' do
      put products_update_url(@product.id),
          params: { name: 'Coca Cola Light', price: 1750, category: 'drink', size: 1000 }
      assert_response :redirect
    end

    test 'should update when put valid product with valid params' do
      put products_update_url(@product.id),
          params: { name: 'Coca Cola Light', price: 1750, category: 'food', size: 1000 }
      updatedproduct = Product.find(@product.id)
      assert_equal('Coca Cola Light', updatedproduct.name)
      assert_equal(1750, updatedproduct.price)
      assert_equal('food', updatedproduct.category)
      assert_equal(1000, updatedproduct.size)
    end

    test 'should redirect when put valid product with invalid params' do
      put products_update_url(@product.id),
          params: { name: 'Coca Cola', price: 1750, category: 'drink', size: -500 }
      assert_response :redirect
    end

    test 'should get edit a valid product' do
      get products_edit_url(@product.id)
      assert_response :success
    end

    test 'should redirect when delete valid product' do
      delete products_destroy_url(@product.id)
      assert_response :redirect
    end

    test 'should delete a Product when valid params' do
      assert_difference 'Product.count', -1 do
        delete products_destroy_url(@product.id)
      end
    end
  end

  class ProductsControllerTestForIndex < ActionDispatch::IntegrationTest
    def setup
      @product1 = Product.create(name: 'Coca Cola', price: 1500, category: 'drink', size: 500)
      @product2 = Product.create(name: 'Doritos', price: 1500, category: 'food', size: 500)
      @product3 = Product.create(name: 'Llavero', price: 1500, category: 'souvenir')
    end

    def teardown
      Product.destroy_all
    end

    test 'should get index' do
      get products_index_url
      assert_response :success
    end

    test 'should get all elements when calling index' do
      skip('pending')
    end

    test 'should get index filtered by drink' do
      get "#{products_index_url}?filtered_by=drink"
      assert_response :success
    end

    test 'should get only drinks when calling index filtered by drinks' do
      skip('pending')
    end

    test 'should get index filtered by food' do
      get "#{products_index_url}?filtered_by=food"
      assert_response :success
    end

    test 'should get only food when calling index filtered by food' do
      skip('pending')
    end

    test 'should get index filtered by souvenir' do
      get "#{products_index_url}?filtered_by=souvenir"
      assert_response :success
    end

    test 'should get only souvenir when calling index filtered by souvenir' do
      skip('pending')
    end

    test 'should redirect to index when ask filter by invalid' do
      get "#{products_index_url}?filtered_by=#{SecureRandom.hex(4)}"
      assert_response :redirect
    end
  end

  class ProductsControllerWithNonExistingProductTest < ActionDispatch::IntegrationTest
    test 'should redirect when put invalid product' do
      put products_update_url(SecureRandom.hex(4)),
          params: { name: 'Coca Cola', price: 1750, category: 'drink', size: 500 }
      assert_response :redirect
    end

    test 'should redirect when get an invalid product' do
      get products_edit_url(SecureRandom.hex(4))
      assert_response :redirect
    end

    test 'should redirect when delete invalid product' do
      delete products_destroy_url(SecureRandom.hex(4))
      assert_response :redirect
    end

    test 'should not delete a Product when invalid params are given' do
      assert_difference 'Product.count', 0 do
        delete products_destroy_url(SecureRandom.hex(4))
      end
    end
  end
end
