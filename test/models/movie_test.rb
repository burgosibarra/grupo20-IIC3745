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

  test 'Movie con título invalidos' do
    movie = Movie.new(title: 10**129, min_age: 0, language: 'spanish')
    assert_equal(false, movie.valid?)
  end

  test 'Movie con min_age invalidos' do
    movie = Movie.new(title: 'Matrix', min_age: 'hola', language: 'spanish')
    assert_equal(false, movie.valid?)
  end

  test 'Movie con language invalidos' do
    assert_raise(ArgumentError) { Movie.new(title: 'Matrix', min_age: 0, language: 'hola') }
  end
end
