# frozen_string_literal: true

require 'test_helper'

class MovieControllerTest < ActionDispatch::IntegrationTest
  class MovieControllerTestWithoutValidMovie < ActionDispatch::IntegrationTest
    def setup; end

    def teardown
      Movie.destroy_all
    end

    test 'should get home' do
      get home_url
      assert_response :success
    end

    test 'should get new' do
      get movie_new_url
      assert_response :success
    end

    test 'should get list by date' do
      get "#{movies_by_date_url}?date=2000-11-10"
      assert_response :success
    end

    test 'should redirect when post create with valid params' do
      post create_movie_url,
           params: { title: 'Matrix' }
      assert_response :redirect
    end

    test 'should create a new Movie when valid params are given' do
      assert_difference 'Movie.count' do
        post create_movie_url,
             params: { title: 'Matrix' }
      end
    end

    test 'should redirect when post create with invalid params' do
      post create_movie_url,
           params: {}
      assert_response :redirect
    end

    test 'should not create a new Movie when invalid params are given' do
      assert_difference 'Movie.count', 0 do
        post create_movie_url,
             params: {}
      end
    end
  end

  class MovieControllerTestWithValidMovie < ActionDispatch::IntegrationTest
    def setup
      @movie = Movie.create(title: 'Matrix')
    end

    def teardown
      MovieTime.destroy_all
      Movie.destroy_all
    end

    test 'should redirect when post create movie time with valid movie' do
      post new_movie_time_url,
           params: { movie_time: { room: 5, date_start: Date.new(2000, 11, 10),
                                   date_end: Date.new(2000, 11, 12), time: 'TANDA',
                                   movie_id: @movie.id } }
      assert_response :redirect
    end

    test 'should create a new MovieTime when valid params are given' do
      assert_difference 'MovieTime.count' do
        post new_movie_time_url,
             params: { movie_time: { room: 5, date_start: Date.new(2000, 11, 10),
                                     date_end: Date.new(2000, 11, 12), time: 'TANDA',
                                     movie_id: @movie.id } }
      end
    end

    test 'should redirect when post create movie time with invalid movie' do
      post new_movie_time_url,
           params: { movie_time: { room: 5, date_start: Date.new(2000, 11, 10),
                                   date_end: Date.new(2000, 11, 12), time: 'TANDA',
                                   movie_id: SecureRandom.hex(4) } }
      assert_response :redirect
    end

    test 'should not create a new MovieTime when invalid params are given' do
      assert_difference 'MovieTime.count', 0 do
        post new_movie_time_url,
             params: { movie_time: { room: 5, date_start: Date.new(2000, 11, 10),
                                     date_end: Date.new(2000, 11, 12), time: 'TANDA',
                                     movie_id: SecureRandom.hex(4) } }
      end
    end
  end
end
