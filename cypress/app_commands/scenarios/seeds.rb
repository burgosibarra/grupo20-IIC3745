# frozen_string_literal: true

Room.create(number: 1)
Room.create(number: 2)
Room.create(number: 3)
Room.create(number: 4)
Room.create(number: 5)
Room.create(number: 6)
Room.create(number: 7)
Room.create(number: 8)

totoro = Movie.create(title: 'Mi Vecino Totoro (1988)', min_age: 0, language: 'spanish')
pride_and_prejudice = Movie.create(title: 'Pride And Prejudice (2005)', min_age: 0, language: 'english')


it = Movie.create(title: 'It (2017)', min_age: 18, language: "spanish")
it_chapter_two = Movie.create(title: 'It Chapter Two (2019)', min_age: 18, language: "english")

# Santiago
MovieTime.create(room: 1, date_start: Date.new(2022, 12, 1), 
        date_end: Date.new(2022, 12, 31), 
        time: 'TANDA', movie_id: totoro.id, branch: 'Santiago')

MovieTime.create(room: 2, date_start: Date.new(2022, 12, 1),
        date_end: Date.new(2022, 12, 31), time: 'TANDA',
        movie_id: pride_and_prejudice.id, branch: 'Santiago')

MovieTime.create(room: 3, date_start: Date.new(2022, 12, 1), 
        date_end: Date.new(2022, 12, 31), 
        time: 'TANDA', movie_id: it.id, branch: 'Santiago')

MovieTime.create(room: 4, date_start: Date.new(2022, 12, 1),
        date_end: Date.new(2022, 12, 31), time: 'TANDA',
        movie_id: it_chapter_two.id, branch: 'Santiago')



MovieTime.create(room: 5, date_start: Date.new(2022, 12, 1), 
        date_end: Date.new(2022, 12, 31), 
        time: 'TANDA', movie_id: totoro.id, branch: 'Regional')

MovieTime.create(room: 6, date_start: Date.new(2022, 12, 1),
        date_end: Date.new(2022, 12, 31), time: 'TANDA',
        movie_id: pride_and_prejudice.id, branch: 'Regional')

MovieTime.create(room: 7, date_start: Date.new(2022, 12, 1), 
        date_end: Date.new(2022, 12, 31), 
        time: 'TANDA', movie_id: it.id, branch: 'Regional')

MovieTime.create(room: 8, date_start: Date.new(2022, 12, 1),
        date_end: Date.new(2022, 12, 31), time: 'TANDA',
        movie_id: it_chapter_two.id, branch: 'Regional')
