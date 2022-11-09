# frozen_string_literal: true

# Controler that manages all actions related to movie creation, room assignment and movie schedule
class MovieController < ApplicationController
  def home; end

  def new
    @movie_times = MovieTime.new
  end

  def post
    title = params[:title]
    image = params[:image]
    min_age = params[:min_age]
    language = params[:language]
    @movie = Movie.new(title:, image:, min_age:, language:)
    if @movie.save
      redirect_to '/movie/new', notice: 'Pelicula creada con exito'
    else
      redirect_to '/movie/new', notice: @movie.errors.messages
    end
  end

  def create_movie_time
    movie_time_params = params.require(:movie_time).permit(:movie_id, :time, :date_start,
                                                           :date_end, :room, :branch)
    movie_time = MovieTime.create(movie_time_params)
    if movie_time.persisted?
      redirect_to '/movie/new', notice: 'Pelicula asignada con exito'
    else
      redirect_to '/movie/new', notice: movie_time.errors.messages
    end
  end

  def list_by_date
    @date = params[:date]
    @age = params[:age]
    @language = params[:language]
    @branch = params[:branch]
    @filter = Movie.includes(:movie_times).where(['movie_times.date_start <= ? and
                                                   ? <= movie_times.date_end and
                                                   movie_times.branch = ? and
                                                   movies.language = ? and
                                                   movies.min_age <= ?
                                                   ',
                                                  @date, @date,
                                                  MovieTime.branches[@branch],
                                                  Movie.languages[@language],
                                                  @age]).references(:movie_times)
    Rails.logger.debug @filter
  end
end
