# frozen_string_literal: true

require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def teardown
    Movie.destroy_all
  end

  test 'Movie con parametros validos' do
    movie = Movie.new(title: 'Matrix', min_age: 0, language: 'spanish')
    assert_equal(true, movie.valid?)
  end

  test 'Movie must have title' do
    movie = Movie.new(min_age: 0, language: 'spanish')
    assert_equal(false, movie.valid?)
  end

  test 'Movie must have min_age' do
    movie = Movie.new(title: 'Matrix', language: 'spanish')
    assert_equal(false, movie.valid?)
  end

  test 'Movie must have language' do
    movie = Movie.new(title: 'Matrix', min_age: 0)
    assert_equal(false, movie.valid?)
  end

  test 'Movie con parametros invalidos' do
    movie = Movie.new
    assert_equal(false, movie.valid?)
  end
end
