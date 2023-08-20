require 'rails_helper'

RSpec.feature 'Search', type: :feature do
  scenario 'user searches for articles' do
    # Create some articles for testing
    article1 = create(:article, title: 'Ruby on Rails Guide')
    article2 = create(:article, title: 'Getting Started with React')

    # Visit the homepage
    visit root_path

    # Fill in the search box
    fill_in 'search-box', with: 'Ruby on Rails'

    # Check if search results are displayed
    expect(page).to have_content('Ruby on Rails Guide')
    expect(page).not_to have_content('Getting Started with React')
  end
end