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
    @margot = Actor.create!(name: "Margot Robbie", age: 28)

    @movie_actor_1 = MovieActor.create!(movie_id: @training_day.id, actor_id: @denzel.id)
    @movie_actor_2 = MovieActor.create!(movie_id: @training_day.id, actor_id: @leo.id)
    @movie_actor_3 = MovieActor.create!(movie_id: @training_day.id, actor_id: @jessica.id)
    @movie_actor_4 = MovieActor.create!(movie_id: @lobster.id, actor_id: @leo.id)
    @movie_actor_4 = MovieActor.create!(movie_id: @lobster.id, actor_id: @margot.id)
    @movie_actor_5 = MovieActor.create!(movie_id: @american_gangster.id, actor_id: @denzel.id)
    @movie_actor_6 = MovieActor.create!(movie_id: @american_gangster.id, actor_id: @jessica.id)

    visit "/actors/#{@denzel.id}"
  end

  it 'shows actor name and age' do
    expect(current_path).to eq("/actors/#{@denzel.id}")

    expect(page).to have_content(@denzel.name)
    expect(page).to have_content(@denzel.age)
  end

  it 'shows all actors co-actors' do
    expect(current_path).to eq("/actors/#{@denzel.id}")

    expect(page).to have_content("Actors #{@denzel.name} has worked with:")
    expect(page).to have_content(@leo.name)
    expect(page).to have_content(@jessica.name)
    expect(page).to_not have_content(@margot.name)
  end
end
