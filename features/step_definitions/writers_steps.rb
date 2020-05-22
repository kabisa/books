Then('I should see {int} cards with writers') do |writers_count|
  within('.card-deck') do
    expect(page).to have_css('.card', count: writers_count)
  end
end
