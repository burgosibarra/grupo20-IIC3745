# frozen_string_literal: true

# The model that represents a reservation of a seat in a room
class Reserva < ApplicationRecord
  enum branch: {
    Santiago: 0,
    Regional: 1
  }

  validates :sala, presence: true, inclusion: { in: [1, 2, 3, 4, 5, 6, 7, 8],
                                                message: '%<value>s no es una sala existente' },
                   uniqueness: { scope: %i[fecha asiento horario] }
  validates :fecha, presence: true
  validates :asiento, presence: true,
                      numericality: { only_integer: true, greater_than: 0, less_than: 49 }
  validates :horario, presence: true, inclusion: { in: %w[MATINÉ TANDA NOCHE],
                                                   message: '%<value>s no es un horario valido' }
  validates :name, presence: true
  validates :branch, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 0 }
  validate :validate_movie_time_exist
  validate :validate_movie_is_not_restricted

  def validate_movie_time_exist
    query = MovieTime.where(['(? <= date_end and ? >= date_start) and
                             time = ? and room = ? and branch = ?',
                             fecha, fecha, horario, sala, Reserva.branches[branch]])
    # rubocop:disable Style/GuardClause
    if query.length.zero?
      errors.add(:none_existing,
                 'No existe una pelicula en esta sala, horario y fecha')
    end
    # rubocop:enable Style/GuardClause
  end

  def validate_movie_is_not_restricted
    query = MovieTime.where(['(? <= date_end and ? >= date_start) and
                             time = ? and room = ? and branch = ?',
                             fecha, fecha, horario, sala, Reserva.branches[branch]])
    # rubocop:disable Style/GuardClause
    if query.length.positive?
      movie = Movie.find(query.first.movie_id)
      if movie.min_age > age
        errors.add(:none_existing,
                   'La pelicula tiene restricción')
      end
    end
    # rubocop:enable Style/GuardClause
  end
end
