# frozen_string_literal: true

# This is the controller for Product model
class ProductsController < ApplicationController
  def new; end

  def create
    name = list_query_params[:name]
    price = list_query_params[:price]
    category = list_query_params[:category]
    size = list_query_params[:size]
    @product = Product.new(name:, price:, category:, size:)
    if @product.save
      redirect_to '/products/index', notice: 'Producto creada con exito'
    else
      redirect_to '/products/new', notice: @product.errors.messages
    end
  end

  def update
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      redirect_to '/products/index',
                  notice: 'Un error inesperado ocurrió, el id no existe'
      return
    end

    @product.name = list_query_params[:name]
    @product.price = list_query_params[:price]
    @product.category = list_query_params[:category]
    @product.size = list_query_params[:size]

    if @product.save
      redirect_to '/products/index', notice: 'Producto actualizado con exito'
    else
      redirect_to "/products/edit/#{params[:id]}", notice: @product.errors.messages
    end
  end

  def edit
    @current = Product.find_by(id: params[:id])
    return unless @current.nil?

    redirect_to '/products/index',
                notice: 'Un error inesperado ocurrió, el id no existe'
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      redirect_to '/products/index',
                  notice: 'Un error inesperado ocurrió, el id no existe'
      return
    end

    @product.destroy
    redirect_to '/products/index', notice: 'Producto eliminado con exito'
  end

  def index
    filtered_by = params['filtered_by']
    if filtered_by.nil?
      @filter = Product.all
    elsif filtered_by == 'drink'
      @filter = Product.where(category: 'drink')
    elsif filtered_by == 'food'
      @filter = Product.where(category: 'food')
    elsif filtered_by == 'souvenir'
      @filter = Product.where(category: 'souvenir')
    else
      redirect_to '/products/index', notice: 'La categoría no existe'
    end
  end

  def list_query_params
    params.permit(:name, :price, :category, :size)
  end
end
