class MovieActorsController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @actors = @movie.actors
  end

  def create
    @movie_actor = MovieActor.add_actor_to_movie(params[:id], params["Add actor"])
    redirect_to "/movies/#{@movie_actor.movie_id}"
  end
end
