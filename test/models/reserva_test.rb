# frozen_string_literal: true

require 'test_helper'

class ReservaTest < ActiveSupport::TestCase
  class ReservaTestWithValidMovie < ActiveSupport::TestCase
    def setup
      movie = Movie.create(title: 'Movie')
      MovieTime.create(room: 5, date_start: Date.new(2022, 10, 10),
                       date_end: Date.new(2022, 10, 12),
                       time: 'TANDA', movie_id: movie.id)
    end

    def teardown
      Reserva.destroy_all
      MovieTime.destroy_all
      Movie.destroy_all
    end

    test 'Reserva creada con parametros validos' do
      reserva = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11),
                               asiento: 10, horario: 'TANDA',
                               name: 'Pedro')
      assert_equal(true, reserva.valid?)
    end

    test 'Reserva no creada con asiento ya reservado' do
      Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11),
                     asiento: 10, horario: 'TANDA',
                     name: 'Pedro')
      reserva2 = Reserva.new(sala: 5, fecha: Date.new(2022, 10, 11),
                             asiento: 10, horario: 'TANDA',
                             name: 'Pedro2')
      assert_equal(false, reserva2.valid?)
    end

    test 'Reserva with invalid params' do
      reserva = Reserva.create(sala: -5, fecha: Date.new(2022, 10, 11),
                               asiento: -10, horario: 'ANY',
                               name: 'Pedro')
      assert_equal(false, reserva.valid?)
    end

    test 'Reserva without params' do
      reserva = Reserva.create
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
                               name: 'Pedro')
      assert_equal(false, reserva.valid?)
    end
  end
end
