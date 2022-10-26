# frozen_string_literal: true

require 'test_helper'

class MovieTimeTest < ActiveSupport::TestCase
  def setup
    @movie = Movie.create(title: 'Matrix')
  end

  def teardown
    Movie.destroy_all
    MovieTime.destroy_all
  end

  test 'MovieTime with valid params' do
    movie_time = MovieTime.new(room: 5, date_start: Date.new(2000, 11, 10),
                               date_end: Date.new(2000, 11, 12), time: 'TANDA',
                               movie_id: @movie.id)
    assert_equal(true, movie_time.valid?)
  end

  test 'MovieTime without params' do
    movie_time = MovieTime.new
    assert_equal(false, movie_time.valid?)
  end

  test 'MovieTime with invalid params' do
    movie_time = MovieTime.new(room: -5, date_start: Date.new(2000, 11, 10),
                               date_end: Date.new(2000, 11, 12), time: 'ANY',
                               movie_id: SecureRandom.hex(4))
    assert_equal(false, movie_time.valid?)
  end

  test 'MovieTime with date_end < date_start' do
    movie_time = MovieTime.new(room: 5, date_start: Date.new(2000, 11, 10),
                               date_end: Date.new(1999, 11, 12), time: 'TANDA',
                               movie_id: @movie.id)
    assert_equal(false, movie_time.valid?)
  end

  test 'MovieTime with in the same place and moment that another' do
    movie1 = Movie.create(title: 'Matrix2')
    MovieTime.create(room: 5, date_start: Date.new(2000, 11, 10),
                     date_end: Date.new(2000, 11, 12), time: 'TANDA',
                     movie_id: movie1.id)
    movie_time2 = MovieTime.new(room: 5, date_start: Date.new(2000, 11, 10),
                                date_end: Date.new(2000, 11, 12), time: 'TANDA',
                                movie_id: @movie.id)
    assert_equal(false, movie_time2.valid?)
  end
end
