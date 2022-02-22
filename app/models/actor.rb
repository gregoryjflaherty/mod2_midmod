class Actor < ApplicationRecord
  has_many :movie_actors
  has_many :movies, through: :movie_actors

  def self.youngest_to_oldest
    order(:age)
  end

  def self.average_age
    average(:age).to_i
  end

  def finds_co_actors
    movies.joins(:movie_actors)
      .joins(:actors).where('name != ?', self.name)
      .distinct.pluck(:name)
  end
end
