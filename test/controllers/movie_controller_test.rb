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
      get "#{movies_by_date_url}?date=2000-11-10&age=20&branch=Santiago&language=spanish"
      assert_response :success
    end

    test 'should redirect when post create with valid params' do
      post create_movie_url,
           params: { title: 'Matrix', min_age: 0, language: 'english' }
      assert_response :redirect
    end

    test 'should create a new Movie when valid params are given' do
      assert_difference 'Movie.count' do
        post create_movie_url,
             params: { title: 'Matrix', min_age: 0, language: 'english' }
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
      @movie = Movie.create(title: 'Matrix', min_age: 0, language: 'english')
    end

    def teardown
      MovieTime.destroy_all
      Movie.destroy_all
    end

    test 'should redirect when post create movie time with valid movie' do
      post new_movie_time_url,
           params: { movie_time: { room: 5, date_start: Date.new(2000, 11, 10),
                                   date_end: Date.new(2000, 11, 12), time: 'TANDA',
                                   movie_id: @movie.id, branch: 'Santiago' } }
      assert_response :redirect
    end

    test 'should create a new MovieTime when valid params are given' do
      assert_difference 'MovieTime.count' do
        post new_movie_time_url,
             params: { movie_time: { room: 5, date_start: Date.new(2000, 11, 10),
                                     date_end: Date.new(2000, 11, 12), time: 'TANDA',
                                     movie_id: @movie.id, branch: 'Santiago' } }
      end
    end

    test 'should redirect when post create movie time with invalid movie' do
      post new_movie_time_url,
           params: { movie_time: { room: 5, date_start: Date.new(2000, 11, 10),
                                   date_end: Date.new(2000, 11, 12), time: 'TANDA',
                                   movie_id: SecureRandom.hex(4), branch: 'Santiago' } }
      assert_response :redirect
    end

    test 'should not create a new MovieTime when invalid params are given' do
      assert_difference 'MovieTime.count', 0 do
        post new_movie_time_url,
             params: { movie_time: { room: 5, date_start: Date.new(2000, 11, 10),
                                     date_end: Date.new(2000, 11, 12), time: 'TANDA',
                                     movie_id: SecureRandom.hex(4), branch: 'Santiago' } }
      end
    end
  end
end
