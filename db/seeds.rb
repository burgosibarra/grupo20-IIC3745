# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with
# its default values.
# The data can then be loaded with the bin/rails db:seed command
# (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Room.create(number: 1)
Room.create(number: 2)
Room.create(number: 3)
Room.create(number: 4)
Room.create(number: 5)
Room.create(number: 6)
Room.create(number: 7)
Room.create(number: 8)
movie_matrix_es = Movie.create(title: 'Matrix ES', min_age: 0, language: 'spanish')
movie_matrix_en = Movie.create(title: 'Matrix EN', min_age: 0, language: 'english')
movie_toystory_es = Movie.create(title: 'Toy Story ES', min_age: 0, language: 'spanish')
movie_toystory_en = Movie.create(title: 'Toy Story EN', min_age: 0, language: 'english')
movie_conjuro_es = Movie.create(title: 'El Conjuro ES', min_age: 18, language: 'spanish')
movie_conjuro_en = Movie.create(title: 'El Conjuro EN', min_age: 18, language: 'english')
movie_annabelle_es = Movie.create(title: 'Annabelle ES', min_age: 18, language: 'spanish')
movie_annabelle_en = Movie.create(title: 'Annabelle EN', min_age: 18, language: 'english')
# Santiago
MovieTime.create(room: 1, date_start: Date.new(2022, 12, 1),
                 date_end: Date.new(2022, 12, 31), time: 'TANDA',
                 movie_id: movie_matrix_es.id, branch: 'Santiago')
MovieTime.create(room: 2, date_start: Date.new(2022, 12, 1),
                 date_end: Date.new(2022, 12, 31), time: 'TANDA',
                 movie_id: movie_matrix_en.id, branch: 'Santiago')
MovieTime.create(room: 3, date_start: Date.new(2022, 12, 1),
                 date_end: Date.new(2022, 12, 31), time: 'TANDA',
                 movie_id: movie_toystory_es.id, branch: 'Santiago')
MovieTime.create(room: 4, date_start: Date.new(2022, 12, 1),
                 date_end: Date.new(2022, 12, 31), time: 'TANDA',
                 movie_id: movie_toystory_en.id, branch: 'Santiago')
MovieTime.create(room: 5, date_start: Date.new(2022, 12, 1),
                 date_end: Date.new(2022, 12, 31), time: 'TANDA',
                 movie_id: movie_conjuro_es.id, branch: 'Santiago')
MovieTime.create(room: 6, date_start: Date.new(2022, 12, 1),
                 date_end: Date.new(2022, 12, 31), time: 'TANDA',
                 movie_id: movie_conjuro_en.id, branch: 'Santiago')
MovieTime.create(room: 7, date_start: Date.new(2022, 12, 1),
                 date_end: Date.new(2022, 12, 31), time: 'TANDA',
                 movie_id: movie_annabelle_es.id, branch: 'Santiago')
MovieTime.create(room: 8, date_start: Date.new(2022, 12, 1),
                 date_end: Date.new(2022, 12, 31), time: 'TANDA',
                 movie_id: movie_annabelle_en.id, branch: 'Santiago')
# Regional
MovieTime.create(room: 1, date_start: Date.new(2022, 12, 1),
                 date_end: Date.new(2022, 12, 31), time: 'TANDA',
                 movie_id: movie_matrix_es.id, branch: 'Regional')
MovieTime.create(room: 2, date_start: Date.new(2022, 12, 1),
                 date_end: Date.new(2022, 12, 31), time: 'TANDA',
                 movie_id: movie_matrix_en.id, branch: 'Regional')
MovieTime.create(room: 3, date_start: Date.new(2022, 12, 1),
                 date_end: Date.new(2022, 12, 31), time: 'TANDA',
                 movie_id: movie_toystory_es.id, branch: 'Regional')
MovieTime.create(room: 4, date_start: Date.new(2022, 12, 1),
                 date_end: Date.new(2022, 12, 31), time: 'TANDA',
                 movie_id: movie_toystory_en.id, branch: 'Regional')
