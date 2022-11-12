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
      reserva = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                            asiento: 10, horario: 'TANDA',
                            name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(true, reserva.valid?)
    end

    test 'Reserva without sala' do
      reserva = Reserva.new(fecha: Date.new(2022, 10, 11),
                            asiento: 10, horario: 'TANDA',
                            name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end

    test 'Reserva with invalid sala <= 0' do
      reserva = Reserva.new(sala: 0, fecha: Date.new(2022, 10, 11),
                            asiento: 10, horario: 'TANDA',
                            name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end

    test 'Reserva with invalid sala > 8' do
      reserva = Reserva.new(sala: 9, fecha: Date.new(2022, 10, 11),
                            asiento: 10, horario: 'TANDA',
                            name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end

    test 'Reserva without fecha' do
      reserva = Reserva.new(sala: 5,
                            asiento: 10, horario: 'TANDA',
                            name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end

    test 'Reserva without asiento' do
      reserva = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                            horario: 'TANDA',
                            name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end

    test 'Reserva with invalid asiento <= 0' do
      reserva = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                            asiento: 0, horario: 'TANDA',
                            name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end

    test 'Reserva with invalid asiento >= 49' do
      reserva = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                            asiento: 49, horario: 'TANDA',
                            name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end

    test 'Reserva with invalid asiento, not integer' do
      reserva = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                            asiento: 'hola', horario: 'TANDA',
                            name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end

    test 'Reserva without horario' do
      reserva = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                            asiento: 10,
                            name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end

    test 'Reserva with invalid horario' do
      reserva = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                            asiento: 10, horario: 'HOLA',
                            name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end

    test 'Reserva without name' do
      reserva = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                            asiento: 10, horario: 'TANDA',
                            age: 20, branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end

    test 'Reserva without branch' do
      reserva = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                            asiento: 10, horario: 'TANDA',
                            name: 'Pedro', age: 20)
      assert_equal(false, reserva.valid?)
    end

    test 'Reserva with invalid branch' do
      assert_raise(ArgumentError) do
        Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                    asiento: 10, horario: 'TANDA',
                    name: 'Pedro', age: 20, branch: 'HOLA')
      end
    end
  end

  class ReservaTestWithSameMovie < ActiveSupport::TestCase
    def setup
      movie = Movie.create(title: 'Movie', language: 'spanish', min_age: 18)
      MovieTime.create(room: 5, date_start: Date.new(2022, 10, 10),
                       date_end: Date.new(2022, 10, 12),
                       time: 'TANDA', movie_id: movie.id, branch: 'Santiago')
      Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11),
                     asiento: 10, horario: 'TANDA',
                     name: 'Pedro', age: 20, branch: 'Santiago')
    end

    def teardown
      Reserva.destroy_all
      MovieTime.destroy_all
      Movie.destroy_all
    end

    test 'Reserva no creada con asiento ya reservado' do
      reserva = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                            asiento: 10, horario: 'TANDA',
                            name: 'Pedro2', age: 20, branch: 'Santiago')
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

    test 'Reserva without age' do
      reserva = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                            asiento: 10, horario: 'TANDA',
                            name: 'Pedro', branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end

    test 'Reserva with invalid age <= 0' do
      reserva = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                            asiento: 10, horario: 'TANDA',
                            name: 'Pedro', age: 0, branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end

    test 'Reserva is valid if age >= min_age' do
      reserva = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                            asiento: 10, horario: 'TANDA',
                            name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(true, reserva.valid?)
    end

    test 'Reserva is invalid if age < min_age' do
      reserva = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
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
      reserva = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                            asiento: 10, horario: 'TANDA',
                            name: 'Pedro', age: 20, branch: 'Santiago')
      assert_equal(false, reserva.valid?)
    end
  end
end
