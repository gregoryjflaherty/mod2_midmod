require 'rails_helper'

RSpec.describe 'movie show' do
  before(:each) do
    @warner = Studio.create!(name: "Warner Bros", location: "Burbank, CA")
    @a24 = Studio.create!(name: "A24", location: "Culver City, CA")

    @ex_machina = @a24.movies.create!(title: "Ex Machina", creation_year: 2018, genre: "Scifi")
    @lobster = @a24.movies.create!(title: "Lobster", creation_year: 2019, genre: "Comedy")
    @training_day = @warner.movies.create!(title: "Training Day", creation_year: 2010, genre: "Action")
    @american_gangster = @warner.movies.create!(title: "American Gangster", creation_year: 2018, genre: "Action")

    @denzel = Actor.create!(name: "Denzel Washington", age: 44)
    @leo = Actor.create!(name: "Leo DiCaprio", age: 40)
    @jessica = Actor.create!(name: "Jessica Alba", age: 33)

    @movie_actor_1 = MovieActor.create!(movie_id: @training_day.id, actor_id: @denzel.id)
    @movie_actor_2 = MovieActor.create!(movie_id: @training_day.id, actor_id: @leo.id)
    @movie_actor_3 = MovieActor.create!(movie_id: @training_day.id, actor_id: @jessica.id)
    @movie_actor_4 = MovieActor.create!(movie_id: @lobster.id, actor_id: @leo.id)
    @movie_actor_5 = MovieActor.create!(movie_id: @american_gangster.id, actor_id: @denzel.id)
    @movie_actor_6 = MovieActor.create!(movie_id: @american_gangster.id, actor_id: @jessica.id)

    visit "/movies/#{@training_day.id}"
  end

  it 'shows movie title, creation year and genre' do
    expect(current_path).to eq("/movies/#{@training_day.id}")

    expect(page).to have_content(@training_day.title)
    expect(page).to have_content(@training_day.creation_year)
    expect(page).to have_content(@training_day.genre)
  end

  it 'shows all actors in movie, youngest to oldest' do
    expect(current_path).to eq("/movies/#{@training_day.id}")

    within '#actor-0' do
      expect(page).to have_content(@jessica.name)
    end

    within '#actor-1' do
      expect(page).to have_content(@leo.name)
    end

    within '#actor-2' do
      expect(page).to have_content(@denzel.name)
    end
  end

  it 'shows average age of all actors' do
    expect(current_path).to eq("/movies/#{@training_day.id}")

    expect(page).to have_content("Average Age of All Actors: 39")
  end
end
