# frozen_string_literal: true

require 'test_helper'

class ReservaTest < ActiveSupport::TestCase
  class ReservaTestWithNonRestrictedMovie < ActiveSupport::TestCase
    def setup
      movie = Movie.create(title: 'Movie', language: 'spanish', min_age: 0)
      MovieTime.create(room: 5, date_start: Date.new(2022, 10, 10),
                       date_end: Date.new(2022, 10, 12),
                       time: 'TANDA', movie_id: movie.id, branch: 'Santiago')
    end

    def teardown
      Reserva.destroy_all
      MovieTime.destroy_all
      Movie.destroy_all
    end

    test 'Reserva creada con parametros validos' do
      reserva = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11),
                               asiento: 10, horario: 'TANDA',
                               name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(true, reserva.valid?)
    end

    test 'Reserva no creada con asiento ya reservado' do
      Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11),
                     asiento: 10, horario: 'TANDA',
                     name: 'Pedro', age: 20, branch: 'Santiago')
      reserva2 = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                             asiento: 10, horario: 'TANDA',
                             name: 'Pedro2', age: 20, branch: 'Santiago')
      assert_equal(false, reserva2.valid?)
    end

    test 'Reserva with invalid params' do
      reserva = Reserva.create(sala: -5, fecha: Date.new(2022, 10, 11),
                               asiento: -10, horario: 'ANY',
                               name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end

    test 'Reserva without params' do
      reserva = Reserva.create
      assert_equal(false, reserva.valid?)
    end
  end

  class ReservaTestWithRestrictedMovie < ActiveSupport::TestCase
    def setup
      movie = Movie.create(title: 'Movie', language: 'spanish', min_age: 18)
      MovieTime.create(room: 5, date_start: Date.new(2022, 10, 10),
                       date_end: Date.new(2022, 10, 12),
                       time: 'TANDA', movie_id: movie.id, branch: 'Santiago')
    end

    def teardown
      Reserva.destroy_all
      MovieTime.destroy_all
      Movie.destroy_all
    end

    test 'Reserva creada con parametros validos' do
      reserva = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11),
                               asiento: 10, horario: 'TANDA',
                               name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(true, reserva.valid?)
    end

    test 'Reserva no creada con si es menor de edad' do
      reserva = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11),
                               asiento: 10, horario: 'TANDA',
                               name: 'Pedro', age: 16, branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end
  end

  class ReservaTestWithInvalidMovie < ActiveSupport::TestCase
    def teardown
      Reserva.destroy_all
    end
    test 'Reserva without an existent movie' do
      reserva = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11),
                               asiento: 10, horario: 'TANDA',
                               name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end
  end
end
