require 'rails_helper'

RSpec.describe 'new movie_actor' do
  describe 'it can add an actor to movie' do
    before(:each) do
      @a24 = Studio.create!(name: "A24", location: "Culver City, CA")

      @ex_machina = @a24.movies.create!(title: "Ex Machina", creation_year: 2018, genre: "Scifi")

      @denzel = Actor.create!(name: "Denzel Washington", age: 44)
      @leo = Actor.create!(name: "Leo DiCaprio", age: 40)
      @jessica = Actor.create!(name: "Jessica Alba", age: 33)
      @margot = Actor.create!(name: "Margot Robbie", age: 28)

      @movie_actor_1 = MovieActor.create!(movie_id: @ex_machina.id, actor_id: @denzel.id)
      @movie_actor_2 = MovieActor.create!(movie_id: @ex_machina.id, actor_id: @leo.id)
      @movie_actor_3 = MovieActor.create!(movie_id: @ex_machina.id, actor_id: @jessica.id)

      visit "/movies/#{@ex_machina.id}"
    end


    it 'has a form to add actor on movie show page' do
      expect(current_path).to eq("/movies/#{@ex_machina.id}")

      expect(find('form')).to have_content('Add actor')
      expect(page).to have_button("Add Actor to #{@ex_machina.title}")
    end

    it 'adds actor to movie' do
      expect(current_path).to eq("/movies/#{@ex_machina.id}")

      expect(page).to_not have_content("#{@margot.name}")
      fill_in 'Add actor', with: "#{@margot.name}"
      click_on "Add Actor to #{@ex_machina.title}"

      expect(page).to have_content("#{@margot.name}")
    end
  end
end
