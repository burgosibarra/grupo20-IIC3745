# frozen_string_literal: true

require 'test_helper'

class MovieTimeTest < ActiveSupport::TestCase
  def setup
    @movie = Movie.create(title: 'Matrix', min_age: 0, language: 'spanish')
  end

  def teardown
    Movie.destroy_all
    MovieTime.destroy_all
  end

  test 'MovieTime with valid params' do
    movie_time = MovieTime.new(room: 5, date_start: Date.new(2000, 11, 10),
                               date_end: Date.new(2000, 11, 12), time: 'TANDA',
                               movie_id: @movie.id, branch: 'Santiago')
    assert_equal(true, movie_time.valid?)
  end

  test 'MovieTime without room' do
    movie_time = MovieTime.new(date_start: Date.new(2000, 11, 10),
                               date_end: Date.new(2000, 11, 12), time: 'TANDA',
                               movie_id: @movie.id, branch: 'Santiago')
    assert_equal(false, movie_time.valid?)
  end

  test 'MovieTime with invalid room < 0' do
    movie_time = MovieTime.new(room: -5, date_start: Date.new(2000, 11, 10),
                               date_end: Date.new(2000, 11, 12), time: 'TANDA',
                               movie_id: @movie.id, branch: 'Santiago')
    assert_equal(false, movie_time.valid?)
  end

  test 'MovieTime with invalid room > 8' do
    movie_time = MovieTime.new(room: 9, date_start: Date.new(2000, 11, 10),
                               date_end: Date.new(2000, 11, 12), time: 'TANDA',
                               movie_id: @movie.id, branch: 'Santiago')
    assert_equal(false, movie_time.valid?)
  end

  test 'MovieTime with invalid room, not integer' do
    movie_time = MovieTime.new(room: '9', date_start: Date.new(2000, 11, 10),
                               date_end: Date.new(2000, 11, 12), time: 'TANDA',
                               movie_id: @movie.id, branch: 'Santiago')
    assert_equal(false, movie_time.valid?)
  end

  test 'MovieTime without time' do
    movie_time = MovieTime.new(room: 5, date_start: Date.new(2000, 11, 10),
                               date_end: Date.new(2000, 11, 12),
                               movie_id: @movie.id, branch: 'Santiago')
    assert_equal(false, movie_time.valid?)
  end

  test 'MovieTime with invalid time' do
    movie_time = MovieTime.new(room: 5, date_start: Date.new(2000, 11, 10),
                               date_end: Date.new(2000, 11, 12), time: 'HOLA',
                               movie_id: @movie.id, branch: 'Santiago')
    assert_equal(false, movie_time.valid?)
  end

  test 'MovieTime without date_start' do
    movie_time = MovieTime.new(room: 5,
                               date_end: Date.new(2000, 11, 12), time: 'TANDA',
                               movie_id: @movie.id, branch: 'Santiago')
    assert_equal(false, movie_time.valid?)
  end

  test 'MovieTime without date_end' do
    movie_time = MovieTime.new(room: 5, date_start: Date.new(2000, 11, 10),
                               time: 'TANDA',
                               movie_id: @movie.id, branch: 'Santiago')
    assert_equal(false, movie_time.valid?)
  end

  test 'MovieTime with date_end < date_start' do
    movie_time = MovieTime.new(room: 5, date_start: Date.new(2000, 11, 10),
                               date_end: Date.new(1999, 11, 12), time: 'TANDA',
                               movie_id: @movie.id, branch: 'Santiago')
    assert_equal(false, movie_time.valid?)
  end

  test 'MovieTime without movie id' do
    movie_time = MovieTime.new(room: 5, date_start: Date.new(2000, 11, 10),
                               date_end: Date.new(2000, 11, 12), time: 'TANDA',
                               branch: 'Santiago')
    assert_equal(false, movie_time.valid?)
  end

  test 'MovieTime without branch' do
    movie_time = MovieTime.new(room: 5, date_start: Date.new(2000, 11, 10),
                               date_end: Date.new(2000, 11, 12), time: 'TANDA',
                               movie_id: @movie.id)
    assert_equal(false, movie_time.valid?)
  end

  test 'MovieTime with invalid branch' do
    assert_raise(ArgumentError) do
      MovieTime.new(room: 5, date_start: Date.new(2000, 11, 10),
                    date_end: Date.new(2000, 11, 12), time: 'TANDA',
                    movie_id: @movie.id, branch: 'HOLA')
    end
  end

  test 'MovieTime with in the same place and moment that another' do
    movie1 = Movie.create(title: 'Matrix2', language: 'spanish', min_age: 0)
    MovieTime.create(room: 5, date_start: Date.new(2000, 11, 10),
                     date_end: Date.new(2000, 11, 12), time: 'TANDA',
                     movie_id: movie1.id, branch: 'Santiago')
    movie_time2 = MovieTime.new(room: 5, date_start: Date.new(2000, 11, 10),
                                date_end: Date.new(2000, 11, 12), time: 'TANDA',
                                movie_id: @movie.id, branch: 'Santiago')
    assert_equal(false, movie_time2.valid?)
  end
end
