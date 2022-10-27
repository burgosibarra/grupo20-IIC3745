# frozen_string_literal: true

# The model that represents a product to sell
class Product < ApplicationRecord
  enum category: {
    drink: 0,
    food: 1,
    souvenir: 2
  }

  validates :name, presence: { message: 'Ingresar nombre del producto' }
  validates :price, presence: { message: 'Ingresar precio del producto' }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :category, presence: { message: 'Ingresar categoría del producto' }
  # validates :category, numericality: { in: 0..2 }
  validate :size_presence
  validates :size, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true

  def size_presence
    return unless size.blank? && (category != 'souvenir')

    errors.add(:size, 'Error en el tamaño del producto')
  end

  def price_string
    n = price.to_s
    i = 1
    string = n[-1]
    while i < n.length
      if i % 3 == 0
        string = "." + string
      end
      string = n[-i - 1] + string
      i += 1
    end
    "$" + string
  end

  def size_string
    if category == "drink"
      return size.to_s + " cc"
    elsif category == "food"
      return size.to_s + " gr"
    else 
      return size.to_s
    end
  end
end
