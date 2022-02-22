require 'rails_helper'

RSpec.describe Actor, type: :model do
  describe 'relationships' do
    it { should have_many :movie_actors}
    it { should have_many(:movies).through(:movie_actors)}
  end

  before(:each) do
    @denzel = Actor.create!(name: "Denzel Washington", age: 44)
    @leo = Actor.create!(name: "Leo DiCaprio", age: 40)
    @jessica = Actor.create!(name: "Jessica Alba", age: 33)
  end

  describe "#class methods" do
    describe '#youngest_to_oldest' do
      it 'sorts actors from youngest to oldest' do
        results = [@jessica, @leo, @denzel]
        expect(Actor.youngest_to_oldest).to eq(results)
      end
    end

    describe '#average_age' do
      it 'gets average age of all actors' do
        expect(Actor.average_age).to be(39)
      end
    end
  end

  describe ".instance methods" do
    describe '.finds_co_actors' do
      before(:each) do
        @warner = Studio.create!(name: "Warner Bros", location: "Burbank, CA")

        @training_day = @warner.movies.create!(title: "Training Day", creation_year: 2010, genre: "Action")
        @american_gangster = @warner.movies.create!(title: "American Gangster", creation_year: 2018, genre: "Action")

        @denzel = Actor.create!(name: "Denzel Washington", age: 44)
        @leo = Actor.create!(name: "Leo DiCaprio", age: 40)
        @jessica = Actor.create!(name: "Jessica Alba", age: 33)
        @margot = Actor.create!(name: "Margot Robbie", age: 28)

        @movie_actor_1 = MovieActor.create!(movie_id: @training_day.id, actor_id: @denzel.id)
        @movie_actor_2 = MovieActor.create!(movie_id: @training_day.id, actor_id: @leo.id)
        @movie_actor_3 = MovieActor.create!(movie_id: @training_day.id, actor_id: @jessica.id)
        @movie_actor_5 = MovieActor.create!(movie_id: @american_gangster.id, actor_id: @denzel.id)
        @movie_actor_6 = MovieActor.create!(movie_id: @american_gangster.id, actor_id: @jessica.id)
      end

      it 'finds all co-actors for specific actor' do
        results = [@jessica.name, @leo.name,]
        expect(@denzel.finds_co_actors).to eq(results)
      end
    end
  end
end
