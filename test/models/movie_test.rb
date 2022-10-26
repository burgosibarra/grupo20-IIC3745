# frozen_string_literal: true

require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def teardown
    Movie.destroy_all
  end

  test 'Movie con parametros validos' do
    movie = Movie.create(title: 'Matrix')
    assert_equal(true, movie.valid?)
  end

  test 'Movie con parametros invalidos' do
    movie = Movie.create
    assert_equal(false, movie.valid?)
  end
end
