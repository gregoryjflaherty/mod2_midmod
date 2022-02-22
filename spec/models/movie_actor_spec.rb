require 'rails_helper'

RSpec.describe MovieActor, type: :model do
  describe 'relationships' do
    it {should belong_to(:movie)}
    it {should belong_to(:actor)}
  end

  describe '#class methods' do
    describe '#add_actor_to_movie' do
      before (:each) do
        @a24 = Studio.create!(name: "A24", location: "Culver City, CA")

        @ex_machina = @a24.movies.create!(title: "Ex Machina", creation_year: 2018, genre: "Scifi")

        @denzel = Actor.create!(name: "Denzel Washington", age: 44)
        @leo = Actor.create!(name: "Leo DiCaprio", age: 40)
        @jessica = Actor.create!(name: "Jessica Alba", age: 33)
        @margot = Actor.create!(name: "Margot Robbie", age: 28)

        @movie_actor_1 = MovieActor.create!(movie_id: @ex_machina.id, actor_id: @denzel.id)
        @movie_actor_2 = MovieActor.create!(movie_id: @ex_machina.id, actor_id: @leo.id)
        @movie_actor_3 = MovieActor.create!(movie_id: @ex_machina.id, actor_id: @jessica.id)
      end

      it 'adds an actor to a movie' do
        expect(@ex_machina.actors).to include(@denzel)
        expect(@ex_machina.actors).to include(@leo)
        expect(@ex_machina.actors).to include(@jessica)
        expect(@ex_machina.actors).to_not include(@margot)

        @movie_actor_4 = MovieActor.add_actor_to_movie(@ex_machina.id, @margot.name)
        @ex_machina = Movie.find(@movie_actor_4.movie_id)
        expect(@ex_machina.actors).to include(@denzel)
        expect(@ex_machina.actors).to include(@leo)
        expect(@ex_machina.actors).to include(@jessica)
        expect(@ex_machina.actors).to include(@margot)
      end
    end
  end
end
