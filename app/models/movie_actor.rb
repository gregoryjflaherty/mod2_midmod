class MovieActor < ApplicationRecord
  belongs_to :movie
  belongs_to :actor

  def self.add_actor_to_movie(movie_id, actor_name)
    movie = Movie.find(movie_id)
    actor = Actor.where(name: actor_name)[0]
    @movie_actor = MovieActor.create!(movie_id: movie.id, actor_id: actor.id)
  end
end
