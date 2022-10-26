# frozen_string_literal: true

require 'test_helper'

class ReservasControllerTest < ActionDispatch::IntegrationTest
  def setup
    @movie = Movie.create(title: 'Matrix')
    @movie_time = MovieTime.create(room: 5, date_start: Date.new(2000, 11, 10),
                                   date_end: Date.new(2000, 11, 12), time: 'TANDA',
                                   movie_id: @movie.id)
  end

  def teardown
    Reserva.destroy_all
    MovieTime.destroy_all
    Movie.destroy_all
  end

  test 'get new' do
    get new_reserva_url(@movie_time.room, '2000-11-12', @movie_time.time)
    assert_response :success
  end

  test 'Redirect when post a new reserva with valid params' do
    post new_reserva_url(5, '2000-11-12', 'TANDA'),
         params: { reservation_seats: 'C-3, C-10', name: 'Diego' }
    assert_response :redirect
  end

  test 'Should create a new reserva when valid params are given' do
    assert_difference 'Reserva.count', 2 do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'C-3, C-10', name: 'Diego' }
    end
  end

  test 'Redirect when post a new reserva without name' do
    post new_reserva_url(5, '2000-11-12', 'TANDA'),
         params: { reservation_seats: 'C-3' }
    assert_response :redirect
  end

  test 'Should not create a new reserva when name was not given' do
    assert_difference 'Reserva.count', 0 do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'C-3, C-10' }
    end
  end

  test 'Redirect when post a new reserva without seat' do
    post new_reserva_url(5, '2000-11-12', 'TANDA'),
         params: { reservation_seats: '', name: 'Diego' }
    assert_response :redirect
  end

  test 'Should not create a new reserva when seat was not given' do
    assert_difference 'Reserva.count', 0 do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: '', name: 'Diego' }
    end
  end

  test 'Redirect when post a new reserva that was already taken' do
    Reserva.create(sala: 5, fecha: Date.new(2000, 11, 12),
                   asiento: 39, horario: 'TANDA',
                   name: 'Diego1')
    post new_reserva_url(5, '2000-11-12', 'TANDA'),
         params: { reservation_seats: 'C-3', name: 'Diego2' }
    assert_response :redirect
  end

  test 'Should not create a new reserva when seat was already taken' do
    Reserva.create(sala: 5, fecha: Date.new(2000, 11, 12),
                   asiento: 39, horario: 'TANDA',
                   name: 'Diego1')
    assert_difference 'Reserva.count', 1 do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'C-3', name: 'Diego2' }
    end
  end

  test 'Redirect when post a new reserva with invalid params' do
    post new_reserva_url(5, '2000-11-12', 'MATINÉ'),
         params: { reservation_seats: 'C-3', name: 'Diego' }
    assert_response :redirect
  end

  test 'Should not create a new reserva with invalid params' do
    assert_difference 'Reserva.count', 0 do
      post new_reserva_url(5, '2000-11-12', 'MATINÉ'),
           params: { reservation_seats: 'C-3', name: 'Diego' }
    end
  end
end
