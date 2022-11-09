# frozen_string_literal: true

require 'test_helper'

class ReservasControllerTest < ActionDispatch::IntegrationTest
  def setup
    @kidsmovie = Movie.create(title: 'Matrix', min_age: 0, language: 'spanish')
    @adultsmovie = Movie.create(title: 'Matrix2', min_age: 18, language: 'english')
    @kidsmovie_time = MovieTime.create(room: 5, date_start: Date.new(2000, 11, 10),
                                       date_end: Date.new(2000, 11, 12), time: 'TANDA',
                                       movie_id: @kidsmovie.id, branch: 'Regional')
    @adultsmovie_time = MovieTime.create(room: 6, date_start: Date.new(2000, 11, 10),
                                         date_end: Date.new(2000, 11, 12), time: 'TANDA',
                                         movie_id: @adultsmovie.id, branch: 'Regional')
  end

  def teardown
    Reserva.destroy_all
    MovieTime.destroy_all
    Movie.destroy_all
  end

  test 'get new' do
    get new_reserva_url(@kidsmovie_time.room, '2000-11-12', @kidsmovie_time.time, 20)
    assert_response :success
  end

  test 'Redirect when post a new reserva with valid params' do
    post new_reserva_url(5, '2000-11-12', 'TANDA'),
         params: { reservation_seats: 'C-3, C-10', name: 'Hijo de Diego' }
    assert_response :redirect
  end

  test 'Should create a new reserva for kids movie when valid params are given' do
    assert_difference 'Reserva.count', 2 do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'C-3, C-10', name: 'Hijos de Diego', age: 10,
                     branch: 'Regional' }
    end
  end

  test 'Should create a new reserva for adults movie when valid params are given' do
    assert_difference 'Reserva.count', 2 do
      post new_reserva_url(6, '2000-11-12', 'TANDA', 18),
           params: { reservation_seats: 'C-3, C-10', name: 'Diego', age: 20, branch: 'Regional' }
    end
  end

  test 'Should not create a new reserva for adults movie when is under 18' do
    assert_difference 'Reserva.count', 0 do
      post new_reserva_url(6, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'C-3', name: 'Hijo de Diego', age: 10, branch: 'Regional' }
    end
  end

  test 'Should not create a new reserva when the branch is not available' do
    assert_difference 'Reserva.count', 0 do
      post new_reserva_url(6, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'C-3', name: 'Hijo de Diego', age: 10, branch: 'Santiago' }
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
                   name: 'Diego1', branch: 'Regional', age: 20)
    assert_difference 'Reserva.count', 1 do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'C-3', name: 'Diego2', branch: 'Regional', age: 20 }
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
