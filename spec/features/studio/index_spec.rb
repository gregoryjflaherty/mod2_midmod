require 'rails_helper'

RSpec.describe 'studio index' do
  before(:each) do
    @warner = Studio.create!(name: "Warner Bros", location: "Burbank, CA")
    @a24 = Studio.create!(name: "A24", location: "Culver City, CA")
    @ex_machina = @a24.movies.create!(title: "Ex Machina", creation_year: 2018, genre: "Scifi")
    @lobster = @a24.movies.create!(title: "Lobster", creation_year: 2019, genre: "Comedy")
    @training_day = @warner.movies.create!(title: "Training Day", creation_year: 2010, genre: "Action")
    @american_gangster = @warner.movies.create!(title: "American Gangster", creation_year: 2018, genre: "Action")

    visit '/studios'
  end

  it 'shows each studio with its name and location' do
    expect(current_path).to eq('/studios')

    within '#studio-0' do
      expect(page).to have_content(@warner.name)
      expect(page).to have_content(@warner.location)
    end


    within '#studio-1' do
      expect(page).to have_content(@a24.name)
      expect(page).to have_content(@a24.location)
    end
  end

  it 'shows each studio with titles of all its movies' do
    expect(current_path).to eq('/studios')
    
    within '#studio-0' do
      expect(page).to have_content(@warner.name)
      expect(page).to have_content(@warner.location)
      expect(page).to have_content(@training_day.title)
      expect(page).to have_content(@american_gangster.title)
    end


    within '#studio-1' do
      expect(page).to have_content(@a24.name)
      expect(page).to have_content(@a24.location)
      expect(page).to have_content(@ex_machina.title)
      expect(page).to have_content(@lobster.title)
    end
  end
end
