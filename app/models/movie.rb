# frozen_string_literal: true

class Movie < ApplicationRecord
  enum language: {
    spanish: 0,
    english: 1
  }

  has_one_attached :image
  has_many :movie_times, dependent: :destroy

  validates :title, presence: { message: 'El titulo no puede estar vacio' }, length: {
    maximum: 128, message: 'El titulo tiene que ser de menos de 128 caracteres'
  }
  validates :language, presence: { message: 'Debe informar el idioma' }
  validates :min_age, numericality: { greater_than_or_equal_to: 0 }
end
